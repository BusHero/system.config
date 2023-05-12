if (Get-Command `
		-Name 'gh' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	return
}

if (Get-Command `
		-Name 'winget' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	winget install --id GitHub.CLI
}
elseif (Get-Command `
		-Name 'choco' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	choco install gh -y
}
