BeforeAll {

}

Describe 'Check Neovim options were set correctly' {
	It 'Line numbers options is turned on' {
		nvim --headless -c 'lua print(nvim.nu:get()) +q' | Should -BeTrue
	}
}