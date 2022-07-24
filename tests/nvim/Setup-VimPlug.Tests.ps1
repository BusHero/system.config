# BeforeAll {

# }

Describe 'Check Neovim options were set correctly' {
	It 'Config path should be the set up one' {
		nvim --headless +"echo stdpath('config')" +q | Should -Be "C:\Users\Petru\AppData\Local\nvim"
	}
}