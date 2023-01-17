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
			$first = Get-Content `
				-Path $profilePath `
				-ErrorAction Ignore
			$second = Get-Content `
				-Path "${PSScriptRoot}\..\profile.ps1" `
				-ErrorAction Ignore
			Compare-Object `
				-ReferenceObject $first `
				-DifferenceObject $second `
				-CaseSensitive `
				-OutVariable result
			$result | Should -BeNullOrEmpty -Because 'files should be the same'
		}

		It 'Run profile' {
			$result = & "$_" -NoProfile -Command ". ${profilePath}; if (`$error) { exit 1 }"
			if ($result) {
				Write-Host "${result}"
			}
			$LASTEXITCODE | Should -Be 0 -Because 'profile should have no warnings'
		}
	}

	It '~\.config folder exists' {
		Test-Path `
			-Path "$($env:USERPROFILE)\.config" `
			-PathType Container | Should -BeTrue -Because '~\.config folder should exist'
	}
}

Describe 'scripts folder' -ForEach @(
	'pwsh'
	'powershell'
) {
	BeforeAll {
		$profilePath = & $_ `
			-NoProfile `
			-Command '$PROFILE.CurrentUserAllHosts'
		$profilePath = Split-Path `
			-Path $profilePath `
			-Parent
	}
	It '<_> scripts folder exists' {
		"${profilePath}\ProfileScripts\" | Should -Exist
	}
}
