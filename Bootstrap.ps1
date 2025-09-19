[CmdletBinding()]
param(
    [string] $configFolderName = $env:ConfigFolderName,
    [string] $repository = $env:ConfigRepository,
    [string] $branch = $env:ConfigBranch,
    [string] $username = $env:ConfigUsername
)

if (-not $configFolderName) { $configFolderName = '.config' }
if (-not $repository) { $repository = 'system.config' }
if (-not $branch) { $branch = 'master' }
if (-not $username) { $username = 'BusHero' }


function Get-Timestamp() {
    return Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
}

$timestamp = Get-Timestamp
$zipFolderWithoutLocation
$tempZipArchiveLocation = Join-Path `
    -Path $env:TEMP `
    -ChildPath "${repository}_${timestamp}.zip" 
$tempZipArchiveContentLocation = Join-Path `
    -Path $env:TEMP `
    -ChildPath "${repository}_${timestamp}"
$configPathParent = $env:USERPROFILE

$configPath = Join-Path `
    -Path $configPathParent `
    -ChildPath $configFolderName

$configUri = "https://codeload.github.com/${username}/${repository}/zip/refs/heads/${branch}"
    
Write-Host "Config Folder Name: " -NoNewline
Write-Host $configFolderName -ForegroundColor Blue

Write-Host "Config Repository: " -NoNewline
Write-Host $repository -ForegroundColor Blue

Write-Host "Config Branch: " -NoNewline
Write-Host $branch -ForegroundColor Blue

Write-Host "Config Username: " -NoNewline
Write-Host $username -ForegroundColor Blue

Write-Host "Config Path: " -NoNewline
Write-Host $configPath -ForegroundColor Blue

Write-Host "Config Uri: " -NoNewline
Write-Host $configUri -ForegroundColor Blue

Invoke-WebRequest `
    -Uri $configUri `
    -OutFile $tempZipArchiveLocation

try {
    Expand-Archive -Path $tempZipArchiveLocation -DestinationPath $tempZipArchiveContentLocation

    if (Test-Path -Path $configPath) {
        $backupFolder = Join-Path -Path $configPathParent -ChildPath "${configFolderName}_${timestamp}"
        Move-Item -Path $configPath -Destination $backupFolder
    }

    $downloadedConfigFolder = Join-Path `
        -Path $tempZipArchiveContentLocation `
        -ChildPath "${repository}-${branch}"

    Move-Item `
        -Path $downloadedConfigFolder `
        -Destination $configPath

    $setupScript = Join-Path -Path $configPath -ChildPath 'setup.ps1'

    & $setupScript
}
finally {
    Remove-Item -Path $tempZipArchiveLocation
}