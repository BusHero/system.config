Describe 'WindowsTerminal.settings.json' {
	BeforeAll {
		$path = "$($env:LOCALAPPDATA)\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
	}

	It 'oh my posh file exists' {
		$path | Should -Exist
	}

	It 'right settings' {
		$hash1 = Get-FileHash -Path $path
		$hash2 = Get-FileHash "${PSScriptRoot}\..\resources\settings.json"
		$hash1.Hash | Should -Be $hash2.Hash -Because 'files should be the same '
	}

	It 'Valid Schema' -Skip {
		$response = Invoke-WebRequest -Uri https://aka.ms/terminal-profiles-schema
		$schema = $response.Content
		$json = Get-Content -Path "${PSScriptRoot}\..\resources\settings.json" | Out-String
		Test-Json -Json $json -Schema $schema | Should -BeTrue
	}
}
