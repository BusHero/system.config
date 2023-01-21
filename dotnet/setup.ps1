& "${PSScriptRoot}\scripts\install.ps1"

$foo = pwsh -NoProfile -Command 'Split-Path -Path $PROFILE.CurrentUserAllHosts'
$bar = powershell -NoProfile -Command 'Split-Path -Path $PROFILE.CurrentUserAllHosts'

foreach ($path in $($foo, $bar)) {
	New-Item `
		-Path "${path}\ProfileScripts" `
		-ItemType Directory `
		-Force > $null

	Copy-Item `
		-Path "${PSScriptRoot}\resources\dotnet.ps1" `
		-Destination "${path}\ProfileScripts\"
}
