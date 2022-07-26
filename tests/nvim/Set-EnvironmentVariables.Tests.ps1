BeforeAll {
	. Get-ScriptPath -Path $PSCommandPath -SourceDirectory ''
}

Describe 'Check Neovim options were set correctly' {
	BeforeAll {
		$XdgConfigHome = 'C:\.config'
		$ConfigPath = "${XdgConfigHome}\nvim"
		Set-NeovimEnvironmentVariables -XdgConfigHome $XdgConfigHome 
	}
	It 'Config path should be the set up one' {
		nvim --headless +"echo stdpath('config')" +q 2>&1 | Should -Be $ConfigPath
	}
}