Write-Host "Setup PowerShell Core"
New-Item `
	-Path (Split-Path -Path $PROFILE.CurrentUserAllHosts -Parent) `
	-ItemType Directory `
	-Force > $null
Copy-Item `
	-Path "${PSScriptRoot}\..\resources\profile.ps1" `
	-Destination $PROFILE.CurrentUserAllHosts
Copy-Item `
	-Path "${PSScriptRoot}\..\resources\ProfileScripts" `
	-Destination (Split-Path -Path $Profile.CurrentUserAllHosts -Parent) `
	-Recurse `
	-ErrorAction Ignore
