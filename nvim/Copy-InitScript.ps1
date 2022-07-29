$Destination = "${env:XDG_CONFIG_HOME}\nvim\init.lua"

$parent = Split-Path -Path $Destination -Parent
Write-Host "Ensure '$parent' directory exists ... "
New-Item -Path $parent -ItemType Directory -Force > $null

Write-Host 'Copy init.lua ... '
if (Test-Path -Path $Destination) {
	$root = Split-Path -Path $Destination -Parent
	
	$backup = New-Item -Path "${root}\.backup" -ItemType Directory -Force
	$backup.Attributes += 'Hidden'
	Move-Item -Path $Destination -Destination "${root}\.backup" > $null
}

Copy-Item `
	-Path "${PSScriptRoot}\init.lua" `
	-Destination $Destination `
	-Force > $null
