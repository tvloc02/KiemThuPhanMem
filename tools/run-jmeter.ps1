param(
  [string]$Version = '5.6.3',
  [string]$TestPlanPath = "$(Resolve-Path (Join-Path $PSScriptRoot '..\jmeter\performance_test_wikipedia.jmx'))",
  [string]$ResultsDir = "$(Join-Path (Resolve-Path (Join-Path $PSScriptRoot '..')) 'jmeter\results')"
)

$toolsDir = $PSScriptRoot
$installDir = Join-Path $toolsDir "apache-jmeter-$Version"
$jmeterBat = Join-Path $installDir 'bin\jmeter.bat'

if (-not (Test-Path $jmeterBat)) {
  throw "JMeter not found. Run tools\setup-jmeter.ps1 first. Expected: $jmeterBat"
}

if (-not (Test-Path $ResultsDir)) {
  New-Item -ItemType Directory -Force -Path $ResultsDir | Out-Null
}

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$jtlPath = Join-Path $ResultsDir "jmeter-$timestamp.jtl"
$reportDir = Join-Path $ResultsDir "report-$timestamp"

& $jmeterBat -n -t $TestPlanPath -l $jtlPath -e -o $reportDir

Write-Host "JTL: $jtlPath"
Write-Host "HTML report: $reportDir\index.html"
