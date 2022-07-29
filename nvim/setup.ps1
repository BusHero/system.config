$config = . "${PSScriptRoot}\config.ps1"
. "${PSScriptRoot}\Set-EnvironmentVariables.ps1" -Config $config
# . "${PSScriptRoot}\Setup-ParkerNvim.ps1"
. "${PSScriptRoot}\Copy-InitScript.ps1"
