Import-Module Pester

[PesterConfiguration] $configuration = New-PesterConfiguration

$configuration.Run.Path = "${PSScriptRoot}\..\tests"
$configuration.Run.Exit = $true

Invoke-Pester -Configuration $configuration
