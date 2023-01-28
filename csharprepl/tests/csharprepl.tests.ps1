Describe 'csharprepl' {
	It 'available' {
		Get-Command `
			-Name 'csharprepl' `
			-ErrorAction Ignore `
			-WarningAction Ignore | Should -Not -BeNullOrEmpty
	}
}
