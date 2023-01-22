if (Get-Command `
		-Name 'zoomit' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	return
}
if (Get-Command `
		-Name 'winget' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	winget install sysinternals --accept-package-agreements
}
elseif (Get-Command `
		-Name 'choco' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	choco install zoomit -y
}
