Write-Host 'Setup Powershell ... '
if (!(Get-Command 'pwsh' -ErrorAction Ignore)) {
	choco install powershell-core -y -d -v
}
. "${PSScriptRoot}\powershell\setup.ps1"
Invoke-Pester "${PSScriptRoot}\tests\powershell"

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
