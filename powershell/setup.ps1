Set-PSRepository `
	-Name 'PSGallery' `
	-InstallationPolicy Trusted
Set-ExecutionPolicy `
	-ExecutionPolicy Bypass `
	-Scope Process `
	-Force

& "${PSScriptRoot}\scripts\install.ps1"
& "${PSScriptRoot}\scripts\modules.ps1"

New-Item `
	-Path (Split-Path -Path $PROFILE.CurrentUserAllHosts -Parent) `
	-ItemType Directory `
	-Force > $null
Copy-Item `
	-Path "${PSScriptRoot}\resources\profile.ps1" `
	-Destination $PROFILE.CurrentUserAllHosts

Copy-Item `
	-Path "${PSScriptRoot}\resources\ProfileScripts" `
	-Destination (Split-Path -Path $Profile.CurrentUserAllHosts -Parent) `
	-Recurse `
	-ErrorAction Ignore

. $PROFILE.CurrentUserAllHosts
