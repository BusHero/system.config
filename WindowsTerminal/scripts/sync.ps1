[CmdletBinding()]
param (
	[Parameter()]
	[switch]
	$Reverse
)

$foo = "${PSScriptRoot}\..\resources\settings.json"
$bar = "${env:LOCALAPPDATA}\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"

if ($Reverse) {
	Copy-Item `
		-Path $bar `
		-Destination $foo `
		-Force
}
else {
	New-Item `
		-ItemType Directory `
		-Path "$(Split-Path $bar -Parent)" `
		-Force > $null

	Copy-Item `
		-Path $foo `
		-Destination $bar `
		-Force
}
