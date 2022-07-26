function Set-ConfigHome {
	param (
		[string]$XdgConfigHome
	)
}

function Get-ConfigHome {
	param(
		[string]$XdgConfigHome
	)
}

function Config-Neovim {
	param(
		[string]$ConfigHome
	)
}

# [System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', $env:LOCALAPPDATA, 'User')
# [System.Environment]::SetEnvironmentVariable('XDG_DATA_HOME', $env:LOCALAPPDATA, 'User')
# [System.Environment]::SetEnvironmentVariable('XDG_RUNTIME_DIR', '', 'User')
# [System.Environment]::SetEnvironmentVariable('XDG_STATE_HOME', $env:LOCALAPPDATA, 'User')