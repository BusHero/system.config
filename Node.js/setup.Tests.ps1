Describe 'Node.js should be installed' {
	It 'npm is installed' {
		Get-Command 'npm' -ErrorAction Ignore | Should -Not -Be $Null -Because 'npm should be installed'
	}

	It 'node is installed' {
		Get-Command 'node' -ErrorAction Ignore | Should -Not -Be $Null -Because 'npm should be installed'
	}
}