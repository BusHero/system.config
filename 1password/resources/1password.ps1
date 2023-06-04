If (Get-Command `
		-Name op `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	op completion powershell | Out-String | Invoke-Expression
}
else {
}
