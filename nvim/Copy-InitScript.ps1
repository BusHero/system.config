function script:Move-ToTemporaryFile {
	param (
		[string]
		$file
	)
	$tempFile = New-TemporaryFile 
	Move-Item -Path $file -Destination $tempFile -Force
	return $tempFile
}

function script:EnsureBackupFolder {
	param(
		[string]
		$BackupFolder
	)
	if (Test-Path $BackupFolder -PathType Container) {
		return
	}
	if (Test-Path $BackupFolder) {
		$tempFile = Move-ToTemporaryFile -file $BackupFolder 
	}
	
	$backup = New-Item -Path $BackupFolder -ItemType Directory -Force
	$backup.Attributes += 'Hidden'
	
	if ($tempFile) {
		Move-Item -Path $tempFile -Destination "${BackupFolder}\.backup"
	}
}


$parent = "${env:XDG_CONFIG_HOME}\nvim"
$ConfigDestionation = "${parent}\init.lua"
$BackupFolder = "${parent}\.backup"


Write-Host "Ensure '$parent' directory exists ... "
New-Item -Path $parent -ItemType Directory -Force > $null

Write-Host 'Copy init.lua ... '
if (Test-Path -Path $ConfigDestionation) {
	EnsureBackupFolder -BackupFolder $BackupFolder
	if (Test-Path -Path "${BackupFolder}\init*.lua") {
		$numbers = foreach ($file in Get-ChildItem "${BackupFolder}\init*.lua") {
			$file -match 'init(?:\.(?<digit>\d+))?\.lua' > $null
			[int]$matches.digit
		} 
		$currentIndex = $numbers | Sort-Object -Bottom 1
		$backupDestionation = "${BackupFolder}\init.$($currentIndex + 1).lua"
		Move-Item -Path $ConfigDestionation -Destination $backupDestionation > $null
	}
	else {
		Move-Item -Path $ConfigDestionation -Destination $BackupFolder > $null
	}
}

Copy-Item -Path "${PSScriptRoot}\init.lua" -Destination $ConfigDestionation -Force > $null
