BeforeAll {
	$path = Get-ScriptPath -Path $PSCommandPath -SourceDirectory ''
}

Describe 'Check Neovim options were set correctly' -ForEach @(
	@{
		Config     = @{
			Variables = @{ 
				XDG_CONFIG_HOME = 'C:\foo'; 
				XDG_DATA_HOME   = 'C:\bar' 
			}
		}
		Parameters = @{ XdgConfigHome = 'C:\foo'; XdgDataHome = 'C:\bar' };
	}
	@{
		Config     = @{
			Variables = @{ 
				XDG_CONFIG_HOME = 'C:\foo'; 
			}
		};
		Parameters = @{ XdgConfigHome = 'C:\foo'; };
	}
	@{
		Config = @{
			Variables = @{  
				XDG_DATA_HOME = 'C:\bar' 
			};
		} 
	}
	@{
		Config = @{
			Variables = {
			}
		}
	}
) {
	It 'Config path should be the set up one' {
		Mock-EnvironmentVariable -Variable 'XDG_CONFIG_HOME', 'XDG_DATA_HOME' -Targets User, Process -Fixture {
			. $path -Config $config
			foreach ($variable in $config.Variables.Keys) {
				[Environment]::GetEnvironmentVariable($variable, 'Process') | Should -Be $Config.Variables.$variable 
				[Environment]::GetEnvironmentVariable($variable, 'User') | Should -Be $Config.Variables.$variable 
			}
		}
	}
}