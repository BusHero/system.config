BeforeAll {
	$path = Get-ScriptPath -Path $PSCommandPath -SourceDirectory ''
}

Describe 'Check Neovim options were set correctly' -ForEach @(
	@{
		Parameters            = @{ XdgConfigHome = 'C:\foo'; XdgDataHome = 'C:\bar' };
		ExpectedXdgConfigHome = 'C:\foo'
		ExpectedXdgDataHome   = 'C:\bar'
	}
	@{
		Parameters            = @{ XdgConfigHome = 'C:\foo'; };
		ExpectedXdgConfigHome = 'C:\foo'
		ExpectedXdgDataHome   = '%LOCALAPPDATA%'
	}
	@{
		Parameters            = @{  XdgDataHome = 'C:\bar' };
		ExpectedXdgConfigHome = '%LOCALAPPDATA%'
		ExpectedXdgDataHome   = 'C:\bar'
	}
	@{
		Parameters            = @{ };
		ExpectedXdgConfigHome = '%LOCALAPPDATA%'
		ExpectedXdgDataHome   = '%LOCALAPPDATA%'
	}
) {
	It 'Config path should be the set up one' {
		Mock-EnvironmentVariable -Variable 'XDG_CONFIG_HOME', 'XDG_DATA_HOME' -Targets User, Process -Fixture {
			. $path @Parameters
			[Environment]::GetEnvironmentVariable('XDG_CONFIG_HOME', 'Process') | Should -Be $ExpectedXdgConfigHome 
			[Environment]::GetEnvironmentVariable('XDG_CONFIG_HOME', 'User') | Should -Be $ExpectedXdgConfigHome 
			[Environment]::GetEnvironmentVariable('XDG_DATA_HOME', 'Process') | Should -Be $ExpectedXdgDataHome 
			[Environment]::GetEnvironmentVariable('XDG_DATA_HOME', 'User') | Should -Be $ExpectedXdgDataHome 
		}
	}
}