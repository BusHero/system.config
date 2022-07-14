Describe 'Check registry is set up' -Tag 'Registry' {
	BeforeAll {
		$Repository = Get-PSRepository -Name 'GitHub' -ErrorAction Ignore
	}
	It 'Github Repository is installed' {
		$Repository | Should -Not -Be $null
	}
	It 'Source location is the right one' {
		$Repository.SourceLocation | Should -Be 'https://nuget.pkg.github.com/BusHero/index.json'
	}
	It 'Repository should be trusted' {
		$Repository.Trusted | Should -BeTrue -Because 'Repository should be trusted'
	}
}