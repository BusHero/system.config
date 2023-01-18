using namespace System.Management.Automation
using namespace System.Management.Automation.Language

. "${PSScriptRoot}\ProfileScripts\functions.ps1"

New-Alias -Name touch -Value New-Item

if ($host.Name -eq 'ConsoleHost') {
	Import-Module PSReadLine
}
Import-Module -Name Terminal-Icons

oh-my-posh `
	--init `
	--shell pwsh `
	--config "$($env:USERPROFILE)\.config\ohmyposh\settings.json" | Invoke-Expression


if (CanUsePredictionSource) {
	switch (Get-Module PSReadLine | Select-Object -ExpandProperty Version) {
		{ $_ -gt '2.2' } {
			Set-PSReadLineOption `
				-PredictionSource History `
				-PredictionViewStyle ListView `
				-WarningAction Ignore `
				-ErrorAction Ignore
			break
		}
		{ $_ -gt '2.1' } {
			Set-PSReadLineOption `
				-PredictionSource History `
				-ErrorAction Ignore `
				-WarningAction Ignore
			break
		}
	}
	Set-PSReadLineOption -EditMode Windows
}

. "${PSScriptRoot}\ProfileScripts\keymappings.ps1"
. "${PSScriptRoot}\ProfileScripts\autocompletion.ps1"
