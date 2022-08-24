param(
	[string]
	$dockerfile,

	[switch]
	$keepContainer,

	[switch]
	$LogIntoContainer
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

if ($LogIntoContainer) {
	docker exec `
		--tty `
		--interactive `
		$dockerContainer `
		powershell -NoLogo
}

if (!$keepContainer) {
	docker rm -f $dockerContainer
}