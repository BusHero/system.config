# if (!($host.Version.Major -eq 7)) {
# 	$env:PSModulePath += ";$($env:USERPROFILE)\Documents\Powershell\Modules"
# }

# $scriptFiles = Get-ChildItem `
# 	-Path "${PSScriptRoot}\ProfileScripts" `
# 	-Filter '*.ps1'

# foreach	($script in $scriptFiles) {
# 	. $script.FullName
# }
$ohMyPoshSettingsFile = Join-Path `
	-Path $env:USERPROFILE `
	-ChildPath '.config' `
	-AdditionalChildPath 'oh-my-posh-settings.json' `
	-Resolve
	
oh-my-posh `
	--init `
	--shell pwsh `
	--config $ohMyPoshSettingsFile | Invoke-Expression
