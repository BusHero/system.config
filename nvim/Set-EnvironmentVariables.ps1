param(
	[string]
	$XdgConfigHome = '%LOCALAPPDATA%',

	[string]
	$XdgDataHome = '%LOCALAPPDATA%'
)

[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', $XdgConfigHome, 'User')
[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', $XdgConfigHome, 'Process')

[System.Environment]::SetEnvironmentVariable('XDG_DATA_HOME', $XdgDataHome, 'User')
[System.Environment]::SetEnvironmentVariable('XDG_DATA_HOME', $XdgDataHome, 'Process')