$tools = & "${PSScriptRoot}\tools.ps1"

foreach ($tool in $tools) {
	Write-Host "Setup ${tool} ..."
	& "${PSScriptRoot}\${tool}\setup.ps1"
}
