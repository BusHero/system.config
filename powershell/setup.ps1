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

# if (! (Get-Command -Name 'oh-my-posh' -ErrorAction Ignore)) {
# 	if (Get-Command -Name 'winget' -ErrorAction Ignore) {
# 		winget install JanDeDobbeleer.OhMyPosh -s winget
# 	}
# 	elseif (Get-Command -Name 'scoop' -ErrorAction Ignore) {
# 		scoop install 'https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json'
# 	}
# 	else {
# 		Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
# 	}
# }

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

New-Item `
	-Path "$($env:USERPROFILE)\.config" `
	-ItemType Directory `
	-Force > $null

Copy-Item `
	-Recurse `
	-Path "${PSScriptRoot}\resources\ohmyposh" `
	-Destination "$($env:USERPROFILE)\.config" `
	-Force

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
