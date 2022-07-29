BeforeAll {
	$script:config = . "$(Get-ScriptPath -Path $PSCommandPath -SourceDirectory '')"
}

Describe 'Config should contain all variables' {
	It '<_> should be present' -TestCases @(
		'XDG_CONFIG_HOME'
		'XDG_DATA_HOME'
	) {
		$config.Variables.Keys | Should -Contain $_
	}
}