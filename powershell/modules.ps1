if (! (Get-InstalledModule -Name 'Terminal-Icons' -ErrorAction Ignore -WarningAction Ignore)) {
	Install-Module `
		-Name Terminal-Icons `
		-Scope CurrentUser `
		-Force
}

if (! (Get-InstalledModule -Name 'posh-git' -ErrorAction Ignore -WarningAction Ignore)) {
	Install-Module `
		-Name posh-git `
		-Scope CurrentUser `
		-Force
}
