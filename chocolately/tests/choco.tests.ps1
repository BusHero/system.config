Describe 'choco' {
	It 'accessible in path' {
		$command = Get-Command `
			-Name 'choco' `
			-ErrorAction Ignore `
			-WarningAction Ignore
		$command | Should -Not -BeNullOrEmpty
	}
}
