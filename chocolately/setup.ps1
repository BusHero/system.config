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
