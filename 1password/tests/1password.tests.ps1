Describe '1password' {
	It 'accesible in path' {
		$command = Get-Command `
			-Name 'op' `
			-ErrorAction Ignore `
			-WarningAction Ignore
		$command | Should -Not -BeNullOrEmpty
	}

	Context 'autocompletion' {
		BeforeAll {
			$path = Get-Location
			Set-Location -Path $TestDrive
		}

		It 'autocompletion' {
			$res = TabExpansion2 -inputScript 'op ' -cursorColumn 3
			$res.CompletionMatches | Should -Not -BeNullOrEmpty
		}
		AfterAll {
			Set-Location -Path $path
		}
	}
}
