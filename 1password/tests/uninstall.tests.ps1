Describe 'op is uninstalled' -Tag uninstalled {
	It 'op is uninstalled' {
		$command = Get-Command `
			-Name 'op' `
			-ErrorAction Ignore `
			-WarningAction Ignore
		$command | Should -BeNullOrEmpty -Because "op should be uninstalled"
	}
}
