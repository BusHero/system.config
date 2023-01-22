if (Get-Command `
		-Name 'code' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	return
}

if (Get-Command `
		-Name 'winget' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	winget install -e --id Microsoft.VisualStudioCode
}
elseif (Get-Command `
		-Name 'choco' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	choco install vscode -y
}
