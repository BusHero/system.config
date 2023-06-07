& "${PSScriptRoot}\scripts\install.ps1"
& "${PSScriptRoot}\scripts\sync.ps1"

New-Item `
	-Path "$($env:USERPROFILE)\.config\" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\assets" `
	-Destination "$($env:USERPROFILE)\.config\WindowsTerminal" `
	-Recurse `
	-Force
