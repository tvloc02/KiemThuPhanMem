param(
  [string]$Version = '5.6.3'
)

$toolsDir = $PSScriptRoot
$installDir = Join-Path $toolsDir "apache-jmeter-$Version"

if (Test-Path $installDir) {
  Write-Host "JMeter already exists: $installDir"
  exit 0
}

$zipUrl = "https://dlcdn.apache.org/jmeter/binaries/apache-jmeter-$Version.zip"
$zipPath = Join-Path $toolsDir "apache-jmeter-$Version.zip"

Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $toolsDir -Force
Remove-Item $zipPath -Force

$jmeterBat = Join-Path $installDir 'bin\jmeter.bat'
if (-not (Test-Path $jmeterBat)) {
  throw "JMeter install failed: $jmeterBat not found"
}

Write-Host "Installed JMeter: $installDir"
