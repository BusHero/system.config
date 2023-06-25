Write-Host "Setup Windows PowerShell"
$path = powershell `
	-NoProfile `
	-Command '$Profile.CurrentUserAllHosts'

New-Item `
	-ItemType HardLink `
	-Path $path `
	-Target $PROFILE.CurrentUserAllHosts `
	-Force > $null
