Write-Host 'Setup NeoVim ...'
. '.\nvim\setup.ps1'

Write-Host 'Run Smoke Tests ...'
Invoke-Pester .\tests\Integration\nvim.Tests.ps1