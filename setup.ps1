[CmdletBinding()]
param (
	[Parameter()]
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

if ($tool) {
	$setupScript = "${PSScriptRoot}\${tool}\setup.ps1"
	Start-Process `
		-FilePath pwsh `
		-Verb RunAs `
		-ArgumentList "-NoProfile -Command ${setupScript}"
}
else {
	$tools = & "${PSScriptRoot}\tools.ps1"

	foreach ($tool in $tools) {
		Write-Host "Setup ${tool} ..."
		& "${PSScriptRoot}\${tool}\setup.ps1"
	}
}
