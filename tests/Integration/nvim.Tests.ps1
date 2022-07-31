BeforeDiscovery {
	function script:Invoke-NeovimCommand([string]$command) { 
		$result = nvim --headless -c $command -c q 2>&1 
		$result = [string[]]$result
		$result = $result | Where-Object { !( $_ -eq 'System.Management.Automation.RemoteException') }
		return [string[]]$result
	}

	enum OptionType {
		Bool
		Int
		String
		StringArray
		IntArray
	}

	function script:Get-NeovimOption() {
		param(
			[string]
			$option,

			[OptionType]
			$Type = [string]
		)
		switch ($Type) {
			Int { return Invoke-NeovimCommand "lua =vim.opt.${option}:get()" -as [int] }
			Bool { return Invoke-NeovimCommand "lua =vim.opt.${option}:get()" -as [bool] }
			String { return Invoke-NeovimCommand "lua =vim.opt.${option}:get()" }
			StringArray { return Invoke-NeovimCommand "lua for _, v in pairs(vim.opt.${option}:get()) do print(v) end" }
			IntArray { return [int[]](Invoke-NeovimCommand "lua for _, v in pairs(vim.opt.${option}:get()) do print(v) end") }
			Default { throw 'Unexpected option' }
		}
	}
}
	
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
		Invoke-NeovimCommand -command 'echo stdpath(''config'')' | Should -Be "$($env:XDG_CONFIG_HOME)\nvim"
	}

	It 'NeoVim Data Directory' {
		Invoke-NeovimCommand -command 'echo stdpath(''data'')' | Should -Be "$($env:XDG_DATA_HOME)\nvim-data"
	}

	It 'Config folder contains init.lua file' {
		"$($env:XDG_CONFIG_HOME)\nvim\init.lua" | Should -Exist 
	}

	It 'Config folder should not contain init.vim file' {
		"$($env:XDG_CONFIG_HOME)\nvim\init.vim" | Should -Not -Exist 
	}
	
	It 'Colorcolumn on 80' {
		Invoke-NeovimCommand -command 'set cc?' | Should -Match ' *colorcolumn=80'
	}

	It 'Lines should be visable' {
		Get-NeovimOption -option number -Type bool | Should -BeTrue
	}
	
	It 'Tabstop is 4 spaces' {
		Get-NeovimOption -option tabstop -Type Int | Should -Be 4
	}

	It 'Shiftstop is 4 spaces' {
		Get-NeovimOption -option shiftwidth -Type Int | Should -Be 4
	}

	It 'Colorcolumns is 80 characters' {
		Get-NeovimOption -option colorcolumn -Type IntArray | Should -Be 80
	}

	It 'Selection with mouse is set on' {
		[bool](Invoke-NeovimCommand -command 'lua =vim.opt.mouse:get().v') | Should -BeTrue
	}

	It 'Add clipboard to buffers' {
		Get-NeovimOption -option clipboard -Type StringArray | Should -Be 'unnamed'
	}
}