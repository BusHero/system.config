Describe 'Node.js should be installed' {
	It 'Node.js should be installed' {
		Get-Command 'npm' -ErrorAction Ignore | Should -Not -Be $Null -Because 'npm should be installed'
	}
}