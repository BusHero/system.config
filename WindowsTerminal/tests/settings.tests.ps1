Describe 'WindowsTerminal.settings.json' {
	BeforeAll {
		$path = "$($env:LOCALAPPDATA)\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
	}

	It 'oh my posh file exists' {
		$path | Should -Exist
	}

	It 'right settings' {
		$first = Get-Content `
			-Path $path `
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

	It 'Valid Schema' -Skip {
		$response = Invoke-WebRequest -Uri https://aka.ms/terminal-profiles-schema
		$schema = $response.Content
		$json = Get-Content -Path "${PSScriptRoot}\..\resources\settings.json" | Out-String
		Test-Json -Json $json -Schema $schema | Should -BeTrue
	}
}
