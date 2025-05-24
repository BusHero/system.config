Describe 'Profile' -ForEach @(
	@{Shell = 'pwsh' }
	@{Shell = 'powershell' }
) {
	BeforeAll {
		$profilePath = & $Shell `
			-NoProfile `
			-Command '$PROFILE.CurrentUserAllHosts'
	}
	It '<Shell> profile scipt exists' {
		$profilePath | Should -Exist
	}

	It 'Match content' {
		$first = Get-FileHash -Path $profilePath
		$second = Get-FileHash -Path "${PSScriptRoot}\..\resources\profile.ps1"
		$first.Hash | Should -Be $second.Hash -Because 'files should be the same'
	}

	It 'Profile contain no errors' {
		$result = & "${shell}" `
			-NoProfile `
			-File $profile.CurrentUserAllHosts
		if ($result) {
			Write-Host "${result}"
		}
		$LASTEXITCODE | Should -Be 0 -Because 'profile should have no warnings'
	}
}
