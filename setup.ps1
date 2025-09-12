[CmdletBinding()]
param (
	[switch]
	$SkipSetupProfile,

	[switch]
	$SkipSetupToolProfileScript,

	[Parameter()]
	[ArgumentCompleter({
			param ( $commandName,
				$parameterName,
				$wordToComplete )
			$constants = & 'C:\.config\tools.ps1'
			$constants | Sort-Object | Where-Object { $_.StartsWith($wordToComplete) }
		})]
	[string]
	$tool
)

if (-not $SkipSetupProfile) {
	$shells = @(
		'powershell',
		'pwsh'
	)

	foreach ($shell in $shells) {
		$profilePath = & $Shell `
			-NoProfile `
			-Command '$PROFILE.CurrentUserAllHosts'
		$directory = Split-Path -Path $profilePath
		write-host $profilePath
		New-Item `
			-Path $profilePath `
			-ItemType SymbolicLink `
			-Target C:\.config\profile.ps1 `
			-Force > $null

		# New-Item `
		# 	-Path $directory\ProfileScripts `
		# 	-ItemType SymbolicLink `
		# 	-Target C:\.config\ProfileScripts `
		# 	-Force > $null
	}
}

if (-not $SkipSetupToolProfileScript) {
	$tools = & "${PSScriptRoot}\tools.ps1"
	foreach ($tool in $tools) {
		$profileScriptsPath = "C:\.config\${tool}\ProfileScripts"

		$profileScripts = if (Test-Path -Path $profileScriptsPath) {
			Get-ChildItem `
				-Path $profileScriptsPath
		}
		else {
			@()
		}

		foreach ($script in $profileScripts) {
			$name = Split-Path `
				-Path $script `
				-Leaf

			New-Item `
				-Path "C:\.config\ProfileScripts\${name}" `
				-ItemType SymbolicLink `
				-Target $script `
				-Force > $null
		}
	}
}
