BeforeAll {
	$script:modules = Get-Module -ListAvailable
}

Describe '<_>' -ForEach @(
	@{ ModuleName = 'Terminal-Icons' }
	@{ ModuleName = 'posh-git' }
	@{ ModuleName = 'Pester' }
	@{ ModuleName = 'PSReadLine' }
) {
	It 'Be Installed' {
		$module = $modules | Where-Object { $_.Name -eq $ModuleName }
		$module | Should -Not -BeNullOrEmpty
	}
}
