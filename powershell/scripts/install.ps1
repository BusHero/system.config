if (Get-Command 'pwsh' -ErrorAction Ignore) {
	return
}

if (Get-Command `
		-Name 'choco' `
		-ErrorAction Ignore `-WarningAction Ignore) {
	choco install powershell-core -y -d -v
}
