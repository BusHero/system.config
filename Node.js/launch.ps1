docker run `
	--mount type="bind,source=${PSScriptRoot},target=C:\scripts" `
	--detach `
	--interactive `
	--name node.js `
	node.js > $null
	
docker exec -i node.js powershell -File 'C:\scripts\setup.ps1'
docker exec -i node.js powershell -command 'Invoke-Pester scripts'

$foo = $LASTEXITCODE
docker rm -f node.js > $null
return $foo