[CmdletBinding()]
param (
	[ArgumentCompleter({
			param ( $commandName,
				$parameterName,
				$wordToComplete )
			$constants = & 'C:\.config\tools.ps1'
			$constants | Sort-Object | Where-Object { $_.StartsWith($wordToComplete) }
		})]
	[string]
	$tool
)

$uninstallScript = "${PSScriptRoot}\${tool}\uninstall.ps1"

Start-Process `
	-FilePath pwsh `
	-Verb RunAs `
	-ArgumentList "-NoProfile -Command ${uninstallScript}"
