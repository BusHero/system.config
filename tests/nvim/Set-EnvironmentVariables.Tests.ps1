BeforeAll {
	$path = Get-ScriptPath -Path $PSCommandPath -SourceDirectory ''
}

Describe 'Check Neovim options were set correctly' {
	BeforeAll {
		$XdgConfigHome = "C:\$(New-Guid)"
	}
	It 'Config path should be the set up one' {
		Mock-EnvironmentVariable -Variable 'XDG_CONFIG_HOME', 'XDG_DATA_HOME' -Targets User, Process -Fixture {
			. $path -XdgConfigHome $XdgConfigHome
			[Environment]::GetEnvironmentVariable('XDG_CONFIG_HOME', 'Process') | Should -Be $XdgConfigHome 
			[Environment]::GetEnvironmentVariable('XDG_CONFIG_HOME', 'User') | Should -Be $XdgConfigHome 
		}
	}
}