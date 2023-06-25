if (!($host.Version.Major -eq 7)) {
	Write-Host "This script requires PowerShell Core"
	Exit 1
}

Set-PSRepository `
	-Name 'PSGallery' `
	-InstallationPolicy Trusted
Set-ExecutionPolicy `
	-ExecutionPolicy Bypass `
	-Scope Process `
	-Force

& "${PSScriptRoot}\scripts\Install-PowershellCore.ps1"
& "${PSScriptRoot}\scripts\Install-Modules.ps1"
& "${PSScriptRoot}\scripts\Setup-PowershellCore.ps1"
& "${PSScriptRoot}\scripts\Setup-WindowsPowershell.ps1"

. $PROFILE.CurrentUserAllHosts
