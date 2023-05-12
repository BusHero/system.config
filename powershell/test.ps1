Write-Host 'Powershell core tests ... '
pwsh -Command '& {
	Import-Module Pester -Version 5.4.1
	Invoke-Pester '${PSScriptRoot}\tests"
}"

Write-Host 'Powershell tests ... '
powershell -Command '& {
	Import-Module Pester -Version 5.4.1
	Invoke-Pester '${PSScriptRoot}\tests"
}"
