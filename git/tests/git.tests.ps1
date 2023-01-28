Describe 'available in path' {
	It 'git' {
		Get-Command `
			-Name 'git' `
			-ErrorAction Ignore `
			-WarningAction Ignore | Should -Not -BeNullOrEmpty
	}
}

