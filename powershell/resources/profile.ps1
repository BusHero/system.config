$scriptFiles = Get-ChildItem `
	-Path "${PSScriptRoot}\ProfileScripts" `
	-Filter '*.ps1'

foreach	($script in $scriptFiles) {
	. $script.FullName
}
