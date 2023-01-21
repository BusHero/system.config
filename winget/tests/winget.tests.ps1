Describe 'miscellenious' {
	Context 'autocompletion' {
		BeforeAll {
			$path = Get-Location
			Set-Location -Path $TestDrive
		}

		It 'autocompletion' {
			$res = TabExpansion2 -inputScript 'winget ' -cursorColumn 6
			$res.CompletionMatches | Should -Not -BeNullOrEmpty
		}
		AfterAll {
			Set-Location -Path $path
		}
	}
}

Describe 'winget.ps1' -ForEach @(
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
		$scriptPath = "${profilePath}\ProfileScripts\winget.ps1"
	}
	It '<Shell> script exists' {
		$scriptPath | Should -Exist
	}
	It 'MatchContent' {
		$first = Get-FileHash -Path $scriptPath
		$second = Get-FileHash -Path "${PSScriptRoot}\..\resources\winget.ps1"
		$first.Hash | Should -Be $second.Hash -Because 'files should be the same'
	}
	It 'IsValid' {
		$result = & $Shell `
			-NoProfile `
			-File "${PSScriptRoot}\..\resources\winget.ps1"
		if ($result) {
			Write-Host "${result}"
		}
		$LASTEXITCODE | Should -Be 0 -Because 'script should have no errors'
	}
}
