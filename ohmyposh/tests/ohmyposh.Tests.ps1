Describe 'ohmyposh' {
	It 'Oh my posh is accessible in path' {
		Get-Command `
			-Name 'oh-my-posh' `
			-ErrorAction Ignore | Should -Not -BeNullOrEmpty -Because "'oh-my-posh' should be setup in path"
	}

	It 'oh my posh file exists' {
		"$($Env:USERPROFILE)\.config\ohmyposh\settings.json" | Should -Exist
	}

	It 'right settings' {
		$first = Get-Content `
			-Path "$($env:USERPROFILE)\.config\ohmyposh\settings.json" `
			-ErrorAction Ignore
		$second = Get-Content `
			-Path "${PSScriptRoot}\..\resources\settings.json" `
			-ErrorAction Ignore
		Compare-Object `
			-ReferenceObject $first `
			-DifferenceObject $second `
			-CaseSensitive `
			-OutVariable result
		$result | Should -BeNullOrEmpty -Because 'files should be the same'
	}

	It 'Valid Schema' {
		$response = Invoke-WebRequest -Uri https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json
		$schema = $response.Content
		$json = Get-Content -Path "${PSScriptRoot}\..\resources\settings.json" | Out-String
		Test-Json -Json $json -Schema $schema | Should -BeTrue
	}

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
}
