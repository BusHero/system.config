Describe 'powershell' {
	It 'Powershell core is installed' {
		Get-Command 'pwsh' -ErrorAction Ignore | Should -Not -BeNullOrEmpty -Because 'PowerShell Core should be installed'
	}

	Describe "Check profile for '<_>'" -ForEach @(
		'powershell',
		'pwsh'
	) {
		BeforeAll {
			$profilePath = & $_ `
				-NoProfile `
				-Command '$PROFILE.CurrentUserAllHosts'
		}

		It 'Profile Path exists' {
			$profilePath | Should -Exist
		}

		It 'Profile should have the right data' {
			$first = Get-FileHash -Path $profilePath
			$second = Get-FileHash -Path "${PSScriptRoot}\..\resources\profile.ps1"
			$first.Hash | Should -Be $second.Hash -Because 'files should be the same'
		}

		It 'Run profile' {
			$result = & "$_" `
				-NoProfile `
				-Command ". ${profilePath}; if (`$error) { exit 1 }"
			if ($result) {
				Write-Host "${result}"
			}
			$LASTEXITCODE | Should -Be 0 -Because 'profile should have no warnings'
		}
	}
}

BeforeDiscovery {
	$files = Get-ChildItem `
		-Path "${PSScriptRoot}\..\resources\ProfileScripts" `
		-Filter '*.ps1'
}

Describe 'scripts folder' -ForEach @(
	@{ Shell = 'pwsh' }
	@{ Shell = 'powershell' }
) {
	BeforeAll {
		$profilePath = & $Shell `
			-NoProfile `
			-Command '$PROFILE.CurrentUserAllHosts'
		$profilePath = Split-Path `
			-Path $profilePath `
			-Parent
	}
	It '<_> scripts folder exists' {
		"${profilePath}\ProfileScripts\" | Should -Exist
	}

	Describe '<_> exists' -ForEach $files {
		BeforeAll {
			$scriptName = Split-Path `
				-Path $_ `
				-Leaf
			$scriptPath = "${profilePath}\ProfileScripts\${scriptName}"
		}

		It 'Exists' {
			$scriptPath | Should -Exist
		}

		It 'MatchContent' {
			$first = Get-FileHash -Path $scriptPath
			$second = Get-FileHash -Path $_
			$first.Hash | Should -Be $second.Hash -Because 'files should be the same'
		}

		It 'IsValid' {
			$result = & $Shell `
				-NoProfile `
				-Command ". ${_}; if (`$error) { exit 1 }"
			if ($result) {
				Write-Host "${result}"
			}
			$LASTEXITCODE | Should -Be 0 -Because 'profile should have no warnings or errors'
		}
	}
}
