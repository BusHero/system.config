choco install op -y

$path = Split-Path `
	-Path $PROFILE.CurrentUserAllHosts

New-Item `
	-Path "${path}\ProfileScripts" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\1password.ps1" `
	-Destination "${path}\ProfileScripts\"
