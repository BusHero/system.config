$Destination = "${env:XDG_CONFIG_HOME}\nvim\init.lua"

$parent = Split-Path -Path $Destination -Parent
Write-Host "Ensure '$parent' directory exists ... "
New-Item -Path $parent -ItemType Directory -Force > $null

Write-Host 'Copy init.lua ... '
Copy-Item `
	-Path "${PSScriptRoot}\init.lua" `
	-Destination $Destination `
	-Force | Out-Null
