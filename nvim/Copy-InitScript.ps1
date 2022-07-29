$Destination = "${env:XDG_CONFIG_HOME}\nvim\init.lua"

New-Item `
	-Path $Destination `
	-ItemType File `
	-Force | Out-Null

Copy-Item `
	-Path "${PSScriptRoot}\init.lua" `
	-Destination $Destination `
	-Force | Out-Null
