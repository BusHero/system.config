# [Cmdlet(VerbsDiagnostic.Test, "RequestConfirmationTemplate1", SupportsShouldProcess = true)]
[CmdletBinding()]
param(
    [string] $configFolderName = '.config',
    [string] $repository = 'system.config',
    [string] $branch = 'master',
    [string] $username = 'BusHero',

    [switch] $Force
)

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
    
if (-not $Force -and $PSCmdlet.ShouldContinue("Download configs from '${configUri}'?", "Install configuration files") -eq $false) {
    return;
}

Invoke-WebRequest `
    -Uri $configUri `
    -OutFile $tempZipArchiveLocation

try {
    Expand-Archive -Path $tempZipArchiveLocation -DestinationPath $tempZipArchiveContentLocation

    if (Test-Path -Path $configPath) {
        if ($Force -or $PSCmdlet.ShouldContinue("Would you like to overwrite '${configPath}'?", "Install configuration files") -eq $false) {
            return;
        }

        $backupFolder = Join-Path -Path $configPathParent -ChildPath "${configFolderName}_${timestamp}"
        Move-Item -Path $configPath -Destination $backupFolder
    }

    $downloadedConfigFolder = Join-Path `
        -Path $tempZipArchiveContentLocation `
        -ChildPath "${repository}-${branch}"

    Move-Item `
        -Path $downloadedConfigFolder `
        -Destination $configPath
}
finally {
    Remove-Item -Path $tempZipArchiveLocation
}