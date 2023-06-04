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
	$tool,

	[Parameter()]
	[switch]
	$uninstall
)
if ($tool) {
	$script = "${PSScriptRoot}\${tool}\test.ps1"
	& $script -uninstall:$uninstall
}
else {
	$tools = & "${PSScriptRoot}\tools.ps1"

	[PesterConfiguration]$configuration = New-PesterConfiguration

	$configuration.Run.Path = $tools | ForEach-Object { "${PSScriptRoot}\${_}\tests" }
	$configuration.Run.Exit = $true

	Invoke-Pester -Configuration $configuration
}
