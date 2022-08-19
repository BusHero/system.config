$zipFile = 'C:\nodejs.zip'
$nodeVersion = 'v18.7.0'
$nodeFolder = "node-${nodeVersion}-win-x64"
$uri = "https://nodejs.org/dist/${nodeVersion}/${nodeFolder}.zip"
$tempFolder = "$($env:TEMP)\nodejs-$(New-Guid)"
$Destination = "$($env:ProgramFiles)\nodejs"

try {
	Write-Host 'Downloading node.js'
	Invoke-WebRequest -Uri $uri -OutFile $zipFile
	
	Write-Host 'Expanding archive'
	Expand-Archive -Path $zipFile -DestinationPath $tempFolder
	
	Write-Host 'Move folder to the right destination'
	Move-Item -Path "${tempFolder}\${nodeFolder}" -Destination $Destination

	Write-Host 'Set path'
	[System.Environment]::SetEnvironmentVariable('Path', "$($env:Path);$($env:ProgramFiles)\nodejs", 'User')
}
finally {
	Write-Host 'Remove Files'
	Remove-Item `
		-Path $zipFile, $tempFolder `
		-Recurse `
		-Force `
		-ErrorAction Ignore
}