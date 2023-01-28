if (!(Get-Command -Name nuke -ErrorAction Ignore -WarningAction Ignore)) {
	dotnet tool install -g nuke.GlobalTool
}

$foo = pwsh -NoProfile -Command 'Split-Path -Path $PROFILE.CurrentUserAllHosts'
$bar = powershell -NoProfile -Command 'Split-Path -Path $PROFILE.CurrentUserAllHosts'

foreach ($path in $($foo, $bar)) {
	New-Item `
		-Path "${path}\ProfileScripts" `
		-ItemType Directory `
		-Force > $null

	Copy-Item `
		-Path "${PSScriptRoot}\resources\nuke.ps1" `
		-Destination "${path}\ProfileScripts\"
}
