Describe 'autocompletion' {
	BeforeAll {
		Set-Location -Path $TestDrive
	}

	It '<tool>' -TestCases @(
		@{ Tool = 'dotnet' }
		@{ Tool = 'gh' }
		@{ Tool = 'winget' }
		@{ Tool = 'oh-my-posh' }
		@{ Tool = 'git' }
	) {
		$res = TabExpansion2 -inputScript $tool -cursorColumn $tool.Length
		$res.CompletionMatches | Should -Not -BeNullOrEmpty
	}
}
