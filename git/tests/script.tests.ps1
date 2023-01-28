Describe 'git.ps1' -ForEach @(
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
		$scriptPath = "${profilePath}\ProfileScripts\git.ps1"
	}
	It '<Shell> script exists' {
		$scriptPath | Should -Exist
	}
	It 'MatchContent' {
		$first = Get-FileHash `
			-Path $scriptPath `
			-ErrorAction Ignore `
			-WarningAction Ignore
		$second = Get-FileHash `
			-Path "${PSScriptRoot}\..\resources\git.ps1" `
			-ErrorAction Ignore `
			-WarningAction Ignore
		$first.Hash | Should -Be $second.Hash -Because 'files should be the same'
	}
	It '<Shell>.IsValid' {
		$result = & $Shell `
			-NoProfile `
			-File "${PSScriptRoot}\..\resources\git.ps1"
		if ($result) {
			Write-Host "${result}"
		}
		$LASTEXITCODE | Should -Be 0 -Because 'script should have no errors'
	}

	Context 'autocompletion' {
		BeforeAll {
			$path = Get-Location
			Set-Location -Path $TestDrive
		}

		It '<shell>.autocompletion' {
			$block = {
				TabExpansion2 -inputScript 'git ' -cursorColumn 4 | Select-Object -ExpandProperty CompletionMatches
			}
			$res = & $shell -Command "${block}"
			$res | Should -Not -BeNullOrEmpty
		}
		AfterAll {
			Set-Location -Path $path
		}
	}
}
