$ModuleRepository = ''
$PSModulePath = @($env:PSModulePath -split ';')[0]
$ModuleName = 'Pester.Extenssions'

$ModulePath = Join-Path -Path $PSModulePath -ChildPath $ModuleName

if (Test-Path -Path $ModuleName) {
	if (Join-Path -Path $ModulePath -ChildPath '.git' | Test-Path) {
		git pull
	}
}
