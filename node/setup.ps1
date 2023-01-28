if (Get-Command `
		-Name node `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	return
}

if (Get-Command `
		-Name winget `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	winget install OpenJS.NodeJS
}
elseif (Get-Command `
		-Name choco `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	choco install nodejs
}
elseif (Get-Command `
		-Name scoop `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	scopp install nodejs
}
