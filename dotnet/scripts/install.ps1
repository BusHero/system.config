if (Get-Command `
		-Name 'dotnet' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	return
}

if (Get-Command `
		-Name 'winget' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	winget install dotnet
}
elseif (Get-Command `
		-Name 'choco' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	choco install dotnet
}
