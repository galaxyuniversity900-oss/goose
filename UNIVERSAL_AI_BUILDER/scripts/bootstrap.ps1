$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
if (-not (Get-Command goose -ErrorAction SilentlyContinue)) {
  throw "Goose CLI not found. Install from https://goose-docs.ai/docs/getting-started/installation"
}
$Dest = Join-Path $env:APPDATA "Block\goose\universal-ai-builder"
$RecipeDest = Join-Path $Dest "recipes"
$DocsDest = Join-Path $Dest "docs"
New-Item -ItemType Directory -Force -Path $RecipeDest,$DocsDest | Out-Null
$Force = $args -contains "--force"
function Copy-Safe([string]$Source,[string]$Target) {
  if ((Test-Path $Target) -and -not $Force) {
    Write-Host "KEEP existing: $Target (use --force to replace)"
    return
  }
  if (Test-Path $Target) {
    $Backup = "$Target.bak.$(Get-Date -Format yyyyMMddHHmmss)"
    Copy-Item $Target $Backup
  }
  Copy-Item $Source $Target -Force
  Write-Host "INSTALLED: $Target"
}
Get-ChildItem (Join-Path $Root "recipes") -Filter *.yaml | ForEach-Object {
  Copy-Safe $_.FullName (Join-Path $RecipeDest $_.Name)
}
Get-ChildItem (Join-Path $Root "docs") -Filter *.md | ForEach-Object {
  Copy-Safe $_.FullName (Join-Path $DocsDest $_.Name)
}
$EnvFile = Join-Path $Dest "env.ps1"
$EnvLines = @(
  '$env:GOOSE_RECIPE_PATH = "' + $RecipeDest + '"',
  '$env:GOOSE_MODE = "approve"',
  '$env:GOOSE_TELEMETRY_ENABLED = "false"',
  '$env:SECURITY_PROMPT_ENABLED = "true"'
)
Set-Content -Path $EnvFile -Value $EnvLines -Encoding UTF8
Write-Host "Run goose configure, configure a provider, source the env.ps1 file, then run goose session."
