if (! (Get-InstalledModule `
			-Name posh-git `
			-ErrorAction Ignore `
			-WarningAction Ignore)) {
	Install-Module -Name posh-git
}
