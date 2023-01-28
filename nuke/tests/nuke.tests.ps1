Describe 'nuke' {
	It 'available' {
		Get-Command `
			-Name 'nuke' `
			-ErrorAction Ignore `
			-WarningAction Ignore | Should -Not -BeNullOrEmpty
	}
}
