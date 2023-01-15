$profilePath = "${PSScriptRoot}\profile.ps1"
$powershellProfilePath = powershell -NoProfile -C '$PROFILE.CurrentUserAllHosts'
$powershellCoreProfilePath = pwsh -NoProfile -C '$PROFILE.CurrentUserAllHosts'

Copy-Item `
	-Path $profilePath `
	-Destination $powershellProfilePath

Copy-Item `
	-Path $profilePath `
	-Destination $powershellCoreProfilePath
