Describe 'software should be installed' -ForEach @(
	@{ Tool = 'choco' }
	@{ Tool = 'npm' }
	@{ Tool = 'node' }
	@{ Tool = 'nvim' }
	@{ Tool = 'code' }
	@{ Tool = 'pwsh' }
	@{ Tool = 'git' }
	@{ Tool = 'gh' }
) {
	It '<tool> is installed' {
		Get-Command $Tool -ErrorAction Ignore | Should -Not -Be $Null -Because "${Tool} should be installed"
	}
}

Describe 'Test paths' -ForEach @(
	@{ Path = "$($env:ProgramFiles)\Mozilla Firefox" }
	@{ Path = 'C:\.config' }
) {
	It '<Path> should exist' {
		$Path | Should -Exist
	}
}