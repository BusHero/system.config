& "${PSScriptRoot}\scripts\install.ps1"

New-Item `
	-Path "$($env:USERPROFILE)\.config\ohmyposh" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\settings.json" `
	-Destination "$($env:USERPROFILE)\.config\ohmyposh\settings.json" `
	-Force

$path = Split-Path `
	-Path $PROFILE.CurrentUserAllHosts

New-Item `
	-Path "${path}\ProfileScripts" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\oh-my-posh.ps1" `
	-Destination "${path}\ProfileScripts\"
