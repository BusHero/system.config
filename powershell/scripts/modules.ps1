if (! (Get-InstalledModule -Name 'Terminal-Icons' -ErrorAction Ignore -WarningAction Ignore)) {
	Install-Module `
		-Name Terminal-Icons `
		-Scope CurrentUser `
		-Force
}
