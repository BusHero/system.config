Write-Output 'Powershell ... '
& "${PSScriptRoot}\powershell\test.ps1"

Write-Output 'ohmyposh ... '
& "${PSScriptRoot}\ohmyposh\test.ps1"

Write-Output 'WindowsTerminal ... '
& "${PSScriptRoot}\WindowsTerminal\test.ps1"

Write-Host 'chocolately ... '
& "${PSScriptRoot}\chocolately\test.ps1"

Write-Host 'winget ... '
& "${PSScriptRoot}\winget\test.ps1"

Write-Host 'dotnet ... '
& "${PSScriptRoot}\dotnet\test.ps1"

Write-Host 'python ... '
& "${PSScriptRoot}\python\test.ps1"

Write-Host 'VSCode ... '
& "${PSScriptRoot}\code\test.ps1"

Write-Host 'sysinternals ... '
& "${PSScriptRoot}\sysinternals\test.ps1"

Write-Host 'git ... '
& "${PSScriptRoot}\git\test.ps1"

Write-Host 'csharprepl ... '
& "${PSScriptRoot}\csharprepl\test.ps1"
