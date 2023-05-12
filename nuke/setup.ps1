$installedTool = Get-Command `
	-Name nuke `
	-ErrorAction Ignore `
	-WarningAction Ignore
if (!$installedTool) {
	dotnet tool install -g nuke.GlobalTool
}

$path = Split-Path `
	-Path $PROFILE.CurrentUserAllHosts

New-Item `
	-Path "${path}\ProfileScripts" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Path "${PSScriptRoot}\resources\nuke.ps1" `
	-Destination "${path}\ProfileScripts\"
