Describe 'node' {
	It 'available' {
		Get-Command `
			-Name node `
			-ErrorAction Ignore `
			-WarningAction Ignore | Should -Not -BeNullOrEmpty
	}
}
