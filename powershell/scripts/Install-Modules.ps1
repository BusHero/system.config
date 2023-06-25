Write-Host "Install Modules"
foreach ($module in @(
		@{ Name = 'Terminal-Icons'; MinimumVersion = '0.10.0' }
		@{ Name = 'Pester'; MinimumVersion = '5.4.1' }
	)) {
	$installedModule = Get-InstalledModule `
		-Name $module.Name `
		-MinimumVersion $module.MinimumVersion `
		-ErrorAction Ignore `
		-WarningAction Ignore

	if (!$installedModule) {
		Install-Module `
			-Name $module.Name `
			-MinimumVersion $module.MinimumVersion `
			-Scope CurrentUser `
			-Force
	}
}
