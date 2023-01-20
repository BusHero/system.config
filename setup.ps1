Write-Host 'Setup Powershell ... '

& "${PSScriptRoot}\powershell\setup.ps1"
& $PROFILE.CurrentUserAllHosts

Write-Host 'Setup oh-my-posh ... '

& "${PSScriptRoot}\ohmyposh\setup.ps1"
# Write-Host 'Setup Windows Terminal ... '
# . "${PSScriptRoot}\WindowsTerminal\setup.ps1"

# Write-Host 'Setup Neo vim ... '
# . "${PSSCriptRoot}\nvim\setup.ps1"

# Write-Host 'Setup Jetbrains ... '
# . "${PSSCriptRoot}\JetBrains\setup.ps1"

# Write-Host 'Setup Git ... '
# . "${PSSCriptRoot}\git\setup.ps1"

# Write-Host 'Setup wsl ... '
# . "${PSSCriptRoot}\wsl\setup.ps1"
