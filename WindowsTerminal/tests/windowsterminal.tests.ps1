Describe 'command ' {
	It 'wt accessible in path' {
		$command = Get-Command `
			-Name 'wt' `
			-ErrorAction Ignore `
			-WarningAction Ignore
		$command | Should -Not -BeNullOrEmpty
	}
}
