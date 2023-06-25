if (!($host.Version.Major -eq 7)) {
	$env:PSModulePath += ";$($env:USERPROFILE)\Documents\Powershell\Modules"
}

$scriptFiles = Get-ChildItem `
	-Path "${PSScriptRoot}\ProfileScripts" `
	-Filter '*.ps1'

foreach	($script in $scriptFiles) {
	. $script.FullName
}
