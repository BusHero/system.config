[CmdletBinding()]
param (
	[Parameter()]
	[switch]
	$Reverse
)

$foo = "${PSScriptRoot}\..\resources\settings.json"
$bar = "${env:LOCALAPPDATA}\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"

if ($Reverse) {
	Write-Output 'if'
	Copy-Item `
		-Path $bar `
		-Destination $foo `
		-Force
}
else {
	Write-Output 'else'
	Write-Output $foo
	Write-Output $bar
	New-Item `
		-ItemType Directory `
		-Path "$(Split-Path $bar -Parent)" `
		-Force > $null

	Copy-Item `
		-Path $foo `
		-Destination $bar `
		-Force

	code $foo
	code $bar
}
