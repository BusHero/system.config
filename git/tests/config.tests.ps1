Describe 'config' {
	BeforeAll {
		Set-Location -Path $TestDrive
	}
	It "'<Key>' = '<Value>'" -ForEach @(
		@{ Key = 'user.name'; Value = 'bus1hero' }
		@{ Key = 'user.email'; Value = 'petru.cervac@gmail.com' }
		@{ Key = 'core.autoclrf'; Value = 'false' }
	) {
		git config --get $Key | Should -Be $Value
	}

	AfterAll {
		Set-Location -Path $PSScriptRoot
	}
}


