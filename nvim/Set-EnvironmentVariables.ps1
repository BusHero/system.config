param(
	[hashtable]
	$Config
)

foreach ($variable in $config.Variables.Keys) {
	New-ItemProperty -Path 'HKCU:\Environment' -Name $variable -Value $Config.Variables.$variable -Force > $null
	
	$processValue = cmd /c "echo $($Config.Variables.$variable)"
	[System.Environment]::SetEnvironmentVariable($variable, $processValue, 'Process')
}