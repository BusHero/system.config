Describe 'software should be installed' -ForEach @(
	@{ Tool = 'choco' }
	@{ Tool = 'npm' }
	@{ Tool = 'node' }
) {
	It '<tool> is installed' {
		Get-Command $Tool -ErrorAction Ignore | Should -Not -Be $Null -Because "${Tool} should be installed"
	}
}