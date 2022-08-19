$resultsFolder = "$($env:TEMP)\pester"

New-Item `
	-Path $resultsFolder `
	-ItemType Directory `
	-Force `
	> $null

docker run `
	--mount type="bind,source=${resultsFolder},target=C:\results" `
	--mount type="bind,source=${PSScriptRoot},target=C:\scripts" `
	--detach `
	--interactive `
	--name node.js `
	node.js `
	> $null

docker exec -i node.js powershell -File 'C:\scripts\setup.ps1'
docker exec -i node.js powershell -File 'C:\scripts\launchTests.ps1'

$foo = $LASTEXITCODE
docker rm -f node.js > $null
return $foo