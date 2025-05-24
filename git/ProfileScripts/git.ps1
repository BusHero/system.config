if (Get-InstalledModule `
		-Name 'posh-git' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	Import-Module -Name posh-git
}
