docker run `
	--mount type="bind,source=${PSScriptRoot},target=C:\scripts" `
	--detach `
	--interactive `
	--name node.js `
	node.js
docker exec -i node.js pwsh -command "& 'C:\scripts\setup.ps1'"
docker exec -i node.js pwsh -command "& 'C:\scripts\setup.Tests.ps1'"
$foo = $LASTEXITCODE
docker rm -f node.js > $null
return $foo