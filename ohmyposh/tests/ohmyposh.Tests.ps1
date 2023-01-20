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
		$first = Get-FileHash -Path "$($env:USERPROFILE)\.config\ohmyposh\settings.json"
		$second = Get-FileHash -Path "${PSScriptRoot}\..\resources\settings.json"
		$first.Hash | Should -Be $second.Hash -Because 'files should be the same'
	}

	It 'Valid Schema' {
		$response = Invoke-WebRequest -Uri https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json
		$schema = $response.Content
		$json = Get-Content -Path "${PSScriptRoot}\..\resources\settings.json" | Out-String
		Test-Json -Json $json -Schema $schema | Should -BeTrue
	}

}
