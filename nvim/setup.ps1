Copy-Item `
	-Path "${PSScriptRoot}\init.vim" `
	-Destination "${env:LOCALAPPDATA}\nvim\init.vim" `
	-Force

Copy-Item `
	-Path "${PSScriptRoot}\coc-settings.json" `
	-Destination "${env:LOCALAPPDATA}\nvim\coc-settings.json" `
	-Force