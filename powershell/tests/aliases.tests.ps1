Describe '<alias>==><definition>' -ForEach @(
	@{ Alias = 'touch'; Definition = 'New-Item' }
) {
	BeforeAll {
		$actualAlias = Get-Alias `
			-Name $Alias `
			-ErrorAction Ignore `
			-WarningAction Ignore
	}
	It 'defined' {
		$actualAlias | Should -Not -BeNullOrEmpty
	}

	It 'rightAlias' {
		$actualAlias.Definition | Should -Be $Definition
	}
}
