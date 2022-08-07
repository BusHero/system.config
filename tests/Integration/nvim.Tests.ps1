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
			$Type = [OptionType]::String
		)
		switch ($Type) {
			Int { return [int](Invoke-NeovimCommand "lua =vim.opt.${option}:get()") }
			Bool { 
				$result = Invoke-NeovimCommand "lua =vim.opt.${option}:get()"
				return [Convert]::ToBoolean($result)
			}
			String { return Invoke-NeovimCommand "lua =vim.opt.${option}:get()" }
			StringArray { return Invoke-NeovimCommand "lua for _, v in pairs(vim.opt.${option}:get()) do print(v) end" }
			IntArray { return [int[]](Invoke-NeovimCommand "lua for _, v in pairs(vim.opt.${option}:get()) do print(v) end") }
			Default { throw 'Unexpected option' }
		}
	}

	function script:Test-NeovimLuaModuleInstalled {
		param(
			[string]
			$module
		)

		$result = Invoke-NeovimCommand -command "lua if pcall(function () require('${module}') end) then print('True') else print('False') end"
		return [Convert]::ToBoolean($result);
	}
}
	
Describe 'Check neovim config' {
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

	It 'Numbers is on' {
		Get-NeovimOption -option number -Type bool | Should -BeTrue
	}

	It 'Relative numbers is on' {
		Get-NeovimOption -option relativenumber bool | Should -BeTrue
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

	Describe 'Check required folders' -ForEach @(
		@{Filename = "$($env:XDG_DATA_HOME)\nvim-data\site\pack\packer\start\packer.nvim"; PathType = 'Container' }
		@{Filename = "$($env:XDG_CONFIG_HOME)\nvim\init.lua"; PathType = 'Leaf' }
		@{Filename = "$($env:XDG_CONFIG_HOME)\nvim\init.lua"; PathType = 'Leaf' }
		@{Filename = "$($env:XDG_CONFIG_HOME)\nvim\lua\plugins.lua"; PathType = 'Leaf' }
	) {
		It '<Filename> should exist' {
			Test-Path -Path $Filename -PathType $PathType | Should -BeTrue
		}
	}

	It 'Packer module is installed' -TestCases @(
		@{ Module = 'packer' }
		@{ Module = 'lspconfig' }
	) {
		Test-NeovimLuaModuleInstalled -module $Module | Should -BeTrue -Because "${Module} should be installed"
	}
}