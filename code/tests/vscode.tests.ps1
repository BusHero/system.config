Describe 'inpath' {
	It 'asd' {
		Get-Command `
			-Name 'code' `
			-ErrorAction Ignore `
			-WarningAction Ignore | Should -Not -BeNullOrEmpty
	}
}
