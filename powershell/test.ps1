Write-Host 'Powershell core tests ... '
pwsh -Command '& {
	Import-Module Pester -MinimumVersion 5.0.0
	Invoke-Pester '${PSScriptRoot}\tests"
}"

Write-Host 'Powershell tests ... '
powershell -Command '& {
	Import-Module Pester -MinimumVersion 5.0.0
	Invoke-Pester '${PSScriptRoot}\tests"
}"
