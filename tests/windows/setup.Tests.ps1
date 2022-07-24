Describe 'Check Windows Setup function' {
	It 'Enable Windows Virtualization' {
		$PSCommandPath | Should -BeNullOrEmpty
	}
	It 'asd' {
		$MyInvocation.MyCommand.Path | Should -BeNullOrEmpty
	}
}