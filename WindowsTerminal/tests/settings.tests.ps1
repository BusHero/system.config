BeforeDiscovery {
	$json = Get-Content -Path "${PSScriptRoot}\..\resources\settings.json" | ConvertFrom-Json
	$paths = $json.profiles.list | `
		ForEach-Object { $_.backgroundImage, $_.startingDirectory, $_.icon } | `
		Where-Object { $_ } | `
		Where-Object { ! $_.StartsWith('ms-appx:') }
}

Describe '<_>' -ForEach $paths {
	BeforeAll {
		$path = cmd /c echo $_
	}

	It 'valid' {
		$path | Should -Exist
	}
}

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

	It 'Commands are valid' {
		$true | Should -BeFalse # TODO implement the test. The idea is to get all commands and check that they are valid
	}
}
