if (Get-Command `
		-Name 'git' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	return
}

if (Get-Command `
		-Name 'winget' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	winget install -e --id Git.Git
}
elseif (Get-Command `
		-Name 'choco' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	choco install git
}
