param(
	[hashtable]
	$Config
)

foreach ($variable in $config.Variables.Keys) {
	[System.Environment]::SetEnvironmentVariable($variable, $Config.Variables.$variable, 'User')
	[System.Environment]::SetEnvironmentVariable($variable, $Config.Variables.$variable, 'Process')
}