& "${PSScriptRoot}\scripts\install.ps1"

$path = Split-Path -Path $PROFILE.CurrentUserAllHosts

New-Item `
	-Path "${path}\ProfileScripts" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\gh.ps1" `
	-Destination "${path}\ProfileScripts\"
