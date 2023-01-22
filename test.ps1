Write-Output 'Powershell ... '
& "${PSScriptRoot}\powershell\test.ps1"

Write-Output 'ohmyposh ... '
& "${PSScriptRoot}\ohmyposh\test.ps1"

Write-Output 'WindowsTerminal ... '
& "${PSScriptRoot}\WindowsTerminal\test.ps1"

Write-Host 'Setup chocolately ... '
& "${PSScriptRoot}\chocolately\test.ps1"

Write-Host 'Setup winget ... '
& "${PSScriptRoot}\winget\test.ps1"

Write-Host 'Setup dotnet ... '
& "${PSScriptRoot}\dotnet\test.ps1"

Write-Host 'Setup python ... '
& "${PSScriptRoot}\python\test.ps1"

Write-Host 'Setup VSCode ... '
& "${PSScriptRoot}\code\test.ps1"

Write-Host 'Setup sysinternals ... '
& "${PSScriptRoot}\sysinternals\test.ps1"
