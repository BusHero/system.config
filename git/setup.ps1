& "${PSScriptRoot}\scripts\install.ps1"
& "${PSScriptRoot}\scripts\config.ps1"
& "${PSScriptRoot}\scripts\modules.ps1"

$path = Split-Path -Path $PROFILE.CurrentUserAllHosts

New-Item `
	-Path "${path}\ProfileScripts" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\git.ps1" `
	-Destination "${path}\ProfileScripts\"
