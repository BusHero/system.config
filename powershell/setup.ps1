function Copy-Profile ([string] $path, [string]$destination) {
	$parent = Split-Path `
		-Path $destination `
		-Parent
	New-Item `
		-Path $parent `
		-ItemType Directory `
		-Force > $null
	Copy-Item `
		-Path $path `
		-Destination $destination
}

function Get-ProfileFolder([string] $shell) {
	& $shell -NoProfile -Command 'Split-Path -Path $Profile.CurrentUserAllHosts -Parent'
}

$SetExecutionPolicy = {
	Set-PSRepository `
		-Name 'PSGallery' `
		-InstallationPolicy Trusted
	Set-ExecutionPolicy `
		-ExecutionPolicy Bypass `
		-Scope Process `
		-Force
	if (!(Get-InstalledModule -Name 'Terminal-Icons' -ErrorAction Ignore)) {
		Install-Module `
			-Name Terminal-Icons `
			-Scope CurrentUser
	}
}

pwsh `
	-NoProfile `
	-Command "$SetExecutionPolicy"
powershell `
	-NoProfile `
	-Command "$SetExecutionPolicy"



$profilePath = "${PSScriptRoot}\resources\profile.ps1"
$powershellProfilePath = powershell `
	-NoProfile `
	-Command '$PROFILE.CurrentUserAllHosts'
$powershellCoreProfilePath = pwsh `
	-NoProfile `
	-Command '$PROFILE.CurrentUserAllHosts'

Copy-Profile `
	-Path $profilePath `
	-Destination $powershellProfilePath

Copy-Profile `
	-Path $profilePath `
	-Destination $powershellCoreProfilePath

pwsh `
	-NoProfile `
	-Command 'Install-Module -Name Terminal-Icons -Scope CurrentUser'
powershell `
	-NoProfile `
	-Command 'Install-Module -Name Terminal-Icons -Scope CurrentUser'

Copy-Item `
	-Path "${PSScriptRoot}\resources\ProfileScripts" `
	-Destination (Get-ProfileFolder -shell 'pwsh') `
	-Recurse `
	-ErrorAction Ignore

Copy-Item `
	-Path "${PSScriptRoot}\resources\ProfileScripts" `
	-Destination (Get-ProfileFolder -shell 'powershell') `
	-Recurse `
	-ErrorAction Ignore

$installCode = {
	Install-Module `
		-Name posh-git `
		-Scope CurrentUser `
		-Force
}

pwsh `
	-NoProfile `
	-Command "${installCode}"
powershell `
	-NoProfile `
	-Command "${installCode}"

. $PROFILE.CurrentUserAllHosts
