& "${PSScriptRoot}\scripts\install.ps1"

New-Item `
	-Path "$($env:USERPROFILE)\.config\ohmyposh" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\settings.json" `
	-Destination "$($env:USERPROFILE)\.config\ohmyposh\settings.json" `
	-Force

$foo = pwsh -NoProfile -Command 'Split-Path -Path $PROFILE.CurrentUserAllHosts'
$bar = powershell -NoProfile -Command 'Split-Path -Path $PROFILE.CurrentUserAllHosts'

foreach ($path in $($foo, $bar)) {
	New-Item `
		-Path "${path}\ProfileScripts" `
		-ItemType Directory `
		-Force > $null

	Copy-Item `
		-Path "${PSScriptRoot}\resources\oh-my-posh.ps1" `
		-Destination "${path}\ProfileScripts\"
}
