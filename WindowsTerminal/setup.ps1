New-Item `
	-ItemType Directory `
	-Path "${env:LOCALAPPDATA}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\" `
	-Force

Copy-Item `
	-Path "${PSScriptRoot}\resources\settings.json" `
	-Destination "${env:LOCALAPPDATA}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" `
	-Force

New-Item `
	-Path "$($env:USERPROFILE)\.config\" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\assets" `
	-Destination "$($env:USERPROFILE)\.config\WindowsTerminal" `
	-Recurse `
	-Force
