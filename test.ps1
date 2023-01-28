$tools = & "${PSScriptRoot}\tools.ps1"

[PesterConfiguration]$configuration = New-PesterConfiguration

$configuration.Run.Path = $tools | ForEach-Object { "${PSScriptRoot}\${_}\tests" }
$configuration.Run.Exit = $true

Invoke-Pester -Configuration $configuration
