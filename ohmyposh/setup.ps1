& "${PSScriptRoot}\scripts\install.ps1"

$shells = @(
	'pwsh',
	'powershell'
)

New-Item `
	-Path "$($env:USERPROFILE)\.config\ohmyposh" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\settings.json" `
	-Destination "$($env:USERPROFILE)\.config\ohmyposh\settings.json" `
	-Force

foreach ($shell in $shells) {
	try {
		$profilePath = & $Shell `
			-NoProfile `
			-Command '$PROFILE.CurrentUserAllHosts'

		$path = Split-Path `
			-Path $profilePath

		New-Item `
			-Path "${path}\ProfileScripts" `
			-ItemType Directory `
			-Force > $null

		Copy-Item `
			-Path "${PSScriptRoot}\resources\oh-my-posh.ps1" `
			-Destination "${path}\ProfileScripts\"
	}
	finally {

	}
}
