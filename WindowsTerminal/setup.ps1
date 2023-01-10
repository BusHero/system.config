New-Item -ItemType Directory `
	-Path "${env:LOCALAPPDATA}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\" `
	-Force

Copy-Item `
	-Path "${PSScriptRoot}\settings.json" `
	-Destination "${env:LOCALAPPDATA}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" `
	-Force
