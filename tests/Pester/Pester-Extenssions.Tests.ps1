BeforeAll {
	. 'C:\.config\src\Pester\Pester-Extenssions.ps1'
}

Describe 'Format Test file' -Tag 'Pester' {
	It 'Get Right Path 1' {
		Get-ScriptPath 'C:\.config\tests\File.Tests.ps1' | Should -Be 'C:\.config\src\File.ps1'
	}
	It 'Get Right Path 2' {
		Get-ScriptPath 'C:\.config\tests\File2.Tests.ps1' | Should -Be 'C:\.config\src\File2.ps1'
	}
}