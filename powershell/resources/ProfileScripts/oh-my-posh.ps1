if (Get-Command `
		-Name 'oh-my-posh' `
		-ErrorAction Ignore) {
	oh-my-posh `
		--init `
		--shell pwsh `
		--config "$($env:USERPROFILE)\.config\ohmyposh\settings.json" | Invoke-Expression

	oh-my-posh completion powershell | Out-String | Invoke-Expression
}
