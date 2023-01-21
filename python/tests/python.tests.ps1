Describe 'python' {
	It 'accessible in path' {
		$command = Get-Command `
			-Name 'python' `
			-ErrorAction Ignore `
			-WarningAction Ignore
		$command | Should -Not -BeNullOrEmpty
	}
}
