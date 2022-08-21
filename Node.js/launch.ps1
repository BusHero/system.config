param (
	[string]
	$dockerImage,
	
	[string]
	$mode
)

$script = "C:\scripts\installers\${mode}.ps1"
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
	$dockerImage `
	> $null

docker exec -i node.js powershell -NoLogo -File $script
docker exec -i node.js powershell -NoLogo -File 'C:\scripts\launchTests.ps1'

$foo = $LASTEXITCODE
docker rm -f node.js > $null
return $foo