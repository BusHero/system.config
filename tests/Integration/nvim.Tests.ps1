Describe 'Environment Variables' {
	BeforeAll {
		$script:projectRoot = Get-ProjectRoot -Path $PSScriptRoot -Markers .git
		$script:config = . "${projectRoot}\nvim\config.ps1"
		$script:environmentVariables = $config.Variables.Keys
	}

	It 'Check environment variables' {
		foreach ($variable in $config.Variables.Keys) {
			[System.Environment]::GetEnvironmentVariable($variable, 'User') | Should -Be $config.Variables.$variable
			
			$processValue = cmd /c "echo $($Config.Variables.$variable)"
			[System.Environment]::GetEnvironmentVariable($variable, 'Process') | Should -Be $processValue
		}
	}

	It 'NeoVim Config directory' {
		nvim --headless -c 'echo stdpath(''config'')' -c q 2>&1 | Should -Be "$($env:XDG_CONFIG_HOME)\nvim"
	}

	It 'NeoVim Data Directory' {
		nvim --headless -c 'echo stdpath(''data'')' -c q 2>&1 | Should -Be "$($env:XDG_DATA_HOME)\nvim-data"
	}

	It 'Config folder contains init.lua file' {
		"$($env:XDG_CONFIG_HOME)\nvim\init.lua" | Should -Exist 
	}

	It 'Config folder should not contain init.vim file' {
		"$($env:XDG_CONFIG_HOME)\nvim\init.vim" | Should -Not -Exist 
	}
}