Describe 'sysinternals' {
	It 'zoomit' {
		Get-Command `
			-Name 'zoomit' `
			-ErrorAction Ignore `
			-WarningAction Ignore | Should -Not -BeNullOrEmpty
	}
}
