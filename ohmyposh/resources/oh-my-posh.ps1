if (Get-Command `
		-Name 'oh-my-posh' `
		-ErrorAction Ignore) {
	oh-my-posh `
		--init `
		--shell pwsh `
		--config "$($env:USERPROFILE)\.config\ohmyposh\settings.json" | Invoke-Expression
}
