param(
	[hashtable]
	$Config
)

foreach ($variable in $config.Variables.Keys) {
	[System.Environment]::SetEnvironmentVariable($variable, $Config.Variables.$variable, 'User')
	
	$processValue = cmd /c "echo $($Config.Variables.$variable)"
	[System.Environment]::SetEnvironmentVariable($variable, $processValue, 'Process')
}