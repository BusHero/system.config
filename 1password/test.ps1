[CmdletBinding()]
param (
	[Parameter()]
	[switch]
	$uninstall
)
if ($uninstall) {
	Invoke-Pester "${PSScriptRoot}\tests" `
		-Tag uninstalled
}
else {
	Invoke-Pester "${PSScriptRoot}\tests" `
		-ExcludeTag uninstalled
}
