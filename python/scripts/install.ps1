if (Get-Command `
		-Name 'python' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	return;
}

if (Get-Command `
		-Name 'winget' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	winget install -e --id Python.Python.3.11
}
