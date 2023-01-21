if (!(Get-Command `
			-Name 'choco' `
			-ErrorAction Ignore `
			-WarningAction Ignore)) {
	Start-Process `
		-FilePath pwsh `
		-ArgumentList '-NoProfile', '-File', "${PSScriptRoot}\scripts\install.ps1" `
		-Verb RunAs `
		-WindowStyle Hidden `
		-Wait
}

$foo = pwsh -NoProfile -Command 'Split-Path -Path $PROFILE.CurrentUserAllHosts'
$bar = powershell -NoProfile -Command 'Split-Path -Path $PROFILE.CurrentUserAllHosts'

foreach ($path in $($foo, $bar)) {
	New-Item `
		-Path "${path}\ProfileScripts" `
		-ItemType Directory `
		-Force > $null

	Copy-Item `
		-Path "${PSScriptRoot}\resources\choco.ps1" `
		-Destination "${path}\ProfileScripts\"
}
