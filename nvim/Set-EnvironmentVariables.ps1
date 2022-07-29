param(
	[string]
	$XdgConfigHome = '%LOCALAPPDATA%'
)

[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', $XdgConfigHome, 'User')
[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', $XdgConfigHome, 'Process')


# [System.Environment]::SetEnvironmentVariable('XDG_DATA_HOME', $env:LOCALAPPDATA, 'User')
# [System.Environment]::SetEnvironmentVariable('XDG_RUNTIME_DIR', '', 'User')
# [System.Environment]::SetEnvironmentVariable('XDG_STATE_HOME', $env:LOCALAPPDATA, 'User')