Describe 'available in path' {
	It 'git' {
		Get-Command `
			-Name 'git' `
			-ErrorAction Ignore `
			-WarningAction Ignore | Should -Not -BeNullOrEmpty
	}
}

Describe 'autocompletion' {
	Context 'autocompletion' {
		BeforeAll {
			Set-Location -Path $TestDrive
		}

		It 'autocompletion' {
			$res = TabExpansion2 -inputScript 'git co' -cursorColumn 6
			$res.CompletionMatches | Should -Not -BeNullOrEmpty
		}
		AfterAll {
			Set-Location -Path $PSScriptRoot
		}
	}
}
