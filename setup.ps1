Write-Host 'Setup Powershell ... '
& "${PSScriptRoot}\powershell\setup.ps1"

Write-Host 'Setup oh-my-posh ... '
& "${PSScriptRoot}\ohmyposh\setup.ps1"

Write-Host 'Setup Windows Terminal ... '
& "${PSScriptRoot}\WindowsTerminal\setup.ps1"

Write-Host 'Setup choco ... '
& "${PSScriptRoot}\chocolately\setup.ps1"

Write-Host 'Setup winget ... '
& "${PSScriptRoot}\winget\setup.ps1"

Write-Host 'Setup dotnet ... '
& "${PSScriptRoot}\dotnet\setup.ps1"

Write-Host 'Setup python ... '
& "${PSScriptRoot}\python\setup.ps1"

Write-Host 'Setup VSCode ... '
& "${PSScriptRoot}\code\setup.ps1"

Write-Host 'Setup Sysinternals ... '
& "${PSScriptRoot}\sysinternals\setup.ps1"

Write-Host 'Setup git ... '
& "${PSScriptRoot}\git\setup.ps1"

Write-Host 'Setup csharprepl ... '
& "${PSScriptRoot}\csharprepl\setup.ps1"


# Write-Host 'Setup Neo vim ... '
# . "${PSSCriptRoot}\nvim\setup.ps1"

# Write-Host 'Setup Jetbrains ... '
# . "${PSSCriptRoot}\JetBrains\setup.ps1"

# Write-Host 'Setup Git ... '
# . "${PSSCriptRoot}\git\setup.ps1"

# Write-Host 'Setup wsl ... '
# . "${PSSCriptRoot}\wsl\setup.ps1"
