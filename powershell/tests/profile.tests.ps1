Describe 'Profile contains no errors' {
	BeforeAll {
		$script:shell = if ($host.Version.Major -eq 5) {
			'powershell'
		}
		else {
			'pwsh'
		}
	}

	It 'Run profile' {
		$result = & "${shell}" `
			-NoProfile `
			-File $profile.CurrentUserAllHosts
		if ($result) {
			Write-Host "${result}"
		}
		$LASTEXITCODE | Should -Be 0 -Because 'profile should have no warnings'
	}
}
