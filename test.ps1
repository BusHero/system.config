Write-Output 'Powershell ... '
& "${PSScriptRoot}\powershell\test.ps1"

Write-Output 'ohmyposh ... '
& "${PSScriptRoot}\ohmyposh\test.ps1"

Write-Output 'WindowsTerminal ... '
& "${PSScriptRoot}\WindowsTerminal\test.ps1"

Write-Host 'Setup chocolately ... '
& "${PSScriptRoot}\chocolately\setup.ps1"

Write-Host 'Setup winget ... '
& "${PSScriptRoot}\winget\setup.ps1"
