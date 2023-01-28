Describe 'nuke' {
	It 'available' {
		Get-Command `
			-Name 'nuke' `
			-ErrorAction Ignore `
			-WarningAction Ignore | Should -Not -BeNullOrEmpty
	}

	Context 'autocompletion' {
		BeforeAll {
			Set-Location -Path $TestDrive
			New-Item `
				-Path "${TestDrive}\.nuke" `
				-ItemType Directory > $null
			'{ "definitions": { "build": { "properties": { "Foo": {} } } } }' |
			Out-File -FilePath "${TestDrive}\.nuke\build.schema.json"
		}

		It '<shell>.autocompletion' -TestCases @(
			@{ Shell = 'pwsh' }
			@{ Shell = 'powershell' }
		) {
			$block = {
				TabExpansion2 -inputScript 'nuke ' -cursorColumn 5 | Select-Object -ExpandProperty CompletionMatches
			}
			$res = & $shell -Command "${block}"
			$res | Should -Not -BeNullOrEmpty
		}
		AfterAll {
			Set-Location -Path $PSScriptRoot
		}
	}
}

Describe 'nuke.ps1' -ForEach @(
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
		$scriptPath = "${profilePath}\ProfileScripts\nuke.ps1"
	}
	It '<Shell> script exists' {
		$scriptPath | Should -Exist
	}
	It 'MatchContent' {
		$first = Get-FileHash -Path $scriptPath
		$second = Get-FileHash -Path "${PSScriptRoot}\..\resources\nuke.ps1"
		$first.Hash | Should -Be $second.Hash -Because 'files should be the same'
	}
	It 'IsValid' {
		$result = & $Shell `
			-NoProfile `
			-File "${PSScriptRoot}\..\resources\nuke.ps1"
		if ($result) {
			Write-Host "${result}"
		}
		$LASTEXITCODE | Should -Be 0 -Because 'script should have no errors'
	}
}
