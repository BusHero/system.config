$existingCommand = Get-Command `
	-Name 'choco' `
	-ErrorAction Ignore `
	-WarningAction Ignore

if (!$existingCommand) {
	Start-Process `
		-FilePath pwsh `
		-ArgumentList '-NoProfile', '-File', "${PSScriptRoot}\scripts\install.ps1" `
		-Verb RunAs `
		-WindowStyle Hidden `
		-Wait
}

$path = Split-Path `
	-Path $PROFILE.CurrentUserAllHosts

New-Item `
	-Path "${path}\ProfileScripts" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\choco.ps1" `
	-Destination "${path}\ProfileScripts\"
