# if (!($host.Version.Major -eq 7)) {
# 	$env:PSModulePath += ";$($env:USERPROFILE)\Documents\Powershell\Modules"
# }

# $scriptFiles = Get-ChildItem `
# 	-Path "${PSScriptRoot}\ProfileScripts" `
# 	-Filter '*.ps1'

# foreach	($script in $scriptFiles) {
# 	. $script.FullName
# }

oh-my-posh `
	--init `
	--shell pwsh `
	--config "$($env:USERPROFILE)\.config\ohmyposh\settings.json" | Invoke-Expression
