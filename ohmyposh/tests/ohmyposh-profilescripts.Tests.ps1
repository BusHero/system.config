BeforeAll {
	. "${PSScriptRoot}\..\resources\oh-my-posh.ps1"
}

Describe 'miscellenious' {
	Context 'autocompletion' {
		BeforeAll {
			$path = Get-Location
			Set-Location -Path $TestDrive
		}

		It 'autocompletion' {
			$res = TabExpansion2 -inputScript 'oh-my-posh ' -cursorColumn 10
			$res.CompletionMatches | Should -Not -BeNullOrEmpty
		}

		AfterAll {
			Set-Location -Path $path
		}
	}
}

Describe 'oh-my-posh.ps1' -ForEach @(
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
		$scriptPath = "${profilePath}\ProfileScripts\oh-my-posh.ps1"
	}
	It '<Shell> script exists' {
		$scriptPath | Should -Exist
	}
	It 'MatchContent' {
		$first = Get-Content `
			-Path $scriptPath `
			-ErrorAction Ignore
		$second = Get-Content `
			-Path "${PSScriptRoot}\..\resources\oh-my-posh.ps1" `
			-ErrorAction Ignore
		Compare-Object `
			-ReferenceObject $first `
			-DifferenceObject $second `
			-CaseSensitive `
			-OutVariable result
		$result | Should -BeNullOrEmpty -Because 'files should be the same'
	}
	It 'IsValid' {
		$result = & $Shell `
			-NoProfile `
			-File "${PSScriptRoot}\..\resources\oh-my-posh.ps1"
		if ($result) {
			Write-Host "${result}"
		}
		$LASTEXITCODE | Should -Be 0 -Because 'script should have no errors'
	}
}
