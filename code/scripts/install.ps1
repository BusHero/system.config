if (Get-Command `
		-Name 'code-insiders' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	return
}

if (Get-Command `
		-Name 'winget' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	winget install -e --id Microsoft.VisualStudioCode.Insiders
}
elseif (Get-Command `
		-Name 'choco' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	choco install vscode-insiders.install -y
}
