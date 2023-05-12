Describe 'available in path' {
	It 'gh' {
		Get-Command `
			-Name 'gh' `
			-ErrorAction Ignore `
			-WarningAction Ignore | Should -Not -BeNullOrEmpty
	}
}
