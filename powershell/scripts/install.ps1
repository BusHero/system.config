if (Get-Command 'pwsh' -ErrorAction Ignore) {
	return
}

if (Get-Command `
		-Name 'winget' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	winget install --id Microsoft.PowerShell.Preview
}
elseif (Get-Command `
		-Name 'choco' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	choco install powershell-preview -y -d -v
}
