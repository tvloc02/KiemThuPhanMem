param(
  [string]$JtlPath = ''
)

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$resultsDir = Join-Path $repoRoot 'jmeter\results'

if ([string]::IsNullOrWhiteSpace($JtlPath)) {
  $latest = Get-ChildItem -Path $resultsDir -Filter 'jmeter-*.jtl' -File | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  if (-not $latest) {
    throw "No .jtl file found in $resultsDir"
  }
  $JtlPath = $latest.FullName
}

if (-not (Test-Path $JtlPath)) {
  throw "JTL not found: $JtlPath"
}

$rows = Import-Csv -Path $JtlPath
if (-not $rows -or $rows.Count -eq 0) {
  throw "Empty JTL: $JtlPath"
}

$parsed = $rows | ForEach-Object {
  $threadName = $_.threadName
  $groupName = $threadName -replace '\s+\d+-\d+$',''

  [pscustomobject]@{
    groupName = $groupName
    timeStamp = [int64]$_.timeStamp
    elapsed = [double]$_.elapsed
    success = [bool]::Parse($_.success)
  }
}

$groups = $parsed | Group-Object groupName

Write-Host "JTL: $JtlPath"
Write-Host ""

$groups | Sort-Object Name | ForEach-Object {
  $name = $_.Name
  $g = $_.Group

  $total = $g.Count
  $errors = ($g | Where-Object { -not $_.success }).Count
  $errorRate = if ($total -gt 0) { [math]::Round(($errors * 100.0) / $total, 2) } else { 0 }

  $avg = [math]::Round((($g | Measure-Object elapsed -Average).Average), 2)

  $minTs = ($g | Measure-Object timeStamp -Minimum).Minimum
  $maxTs = ($g | Measure-Object timeStamp -Maximum).Maximum
  $durationSec = [math]::Max(1, [math]::Round((($maxTs - $minTs) / 1000.0), 0))
  $throughput = [math]::Round(($total / $durationSec), 2)

  Write-Host "[$name]"
  Write-Host "  Total requests: $total"
  Write-Host "  Avg response time (ms): $avg"
  Write-Host "  Throughput (req/s): $throughput"
  Write-Host "  Error rate (%): $errorRate"
  Write-Host ""
}
