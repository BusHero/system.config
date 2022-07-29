BeforeAll {
	$path = Get-ScriptPath -Path $PSCommandPath -SourceDirectory ''
}

Describe 'Check Neovim options were set correctly' -ForEach @(
	@{
		Parameters            = @{ XdgConfigHome = 'C:\foo' };
		ExpectedXdgConfigHome = 'C:\foo'
	}
	@{
		Parameters            = @{ };
		ExpectedXdgConfigHome = '%LOCALAPPDATA%'
	}
) {
	It 'Config path should be the set up one' {
		Mock-EnvironmentVariable -Variable 'XDG_CONFIG_HOME', 'XDG_DATA_HOME' -Targets User, Process -Fixture {
			. $path @Parameters
			[Environment]::GetEnvironmentVariable('XDG_CONFIG_HOME', 'Process') | Should -Be $ExpectedXdgConfigHome 
			[Environment]::GetEnvironmentVariable('XDG_CONFIG_HOME', 'User') | Should -Be $ExpectedXdgConfigHome 
		}
	}
}