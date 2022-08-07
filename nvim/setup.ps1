$config = . "${PSScriptRoot}\config.ps1"
. "${PSScriptRoot}\Set-EnvironmentVariables.ps1" -Config $config

New-Item `
	-Path "$($env:XDG_CONFIG_HOME)\nvim\lua\" `
	-ItemType Directory `
	-Force > $null
Copy-Item `
	-Path "${PSScriptRoot}\plugins.lua" `
	-Destination "$($env:XDG_CONFIG_HOME)\nvim\lua\plugins.lua" `
	-Force > $null

. "${PSScriptRoot}\Copy-InitScript.ps1"

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'