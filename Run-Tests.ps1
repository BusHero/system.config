param(
	[string]
	$dockerfile
)

$dockerImage = 'test-image'
$dockerContainer = "test_$(New-Guid)"


docker build -t $dockerImage -f $dockerfile .

docker run `
	--detach `
	--interactive `
	--name $dockerContainer `
	$dockerImage

docker exec `
	--interactive `
	$dockerContainer `
	powershell -NoLogo -File C:\scripts\install.ps1

docker exec `
	--interactive `
	$dockerContainer `
	powershell -NoLogo -Command 'Invoke-Pester .\tests\install'

docker rm -f $dockerContainer