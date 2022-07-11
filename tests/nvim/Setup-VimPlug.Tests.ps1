BeforeAll {

}

Describe 'Check Neovim options were set correctly' {
	It 'Line numbers options is turned on' {
		$Destination | should -Be "foo"
	}
}