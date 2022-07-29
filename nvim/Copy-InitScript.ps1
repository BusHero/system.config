$parent = "${env:XDG_CONFIG_HOME}\nvim"
$ConfigDestionation = "${parent}\init.lua"
$BackupFolder = "${parent}\.backup"


Write-Host "Ensure '$parent' directory exists ... "
New-Item -Path $parent -ItemType Directory -Force > $null

Write-Host 'Copy init.lua ... '
if (Test-Path -Path $ConfigDestionation) {
	if (Test-Path $BackupFolder -PathType Leaf) {
		$tempFile = New-TemporaryFile 
		Move-Item -Path $BackupFolder -Destination $tempFile -Force
		$backup = New-Item -Path $BackupFolder -ItemType Directory -Force
		$backup.Attributes += 'Hidden'
		Move-Item -Path $tempFile -Destination "${BackupFolder}\.backup"
	}
	elseif ( !( Test-Path $BackupFolder -PathType Container ) ) {
		$backup = New-Item -Path $BackupFolder -ItemType Directory -Force
		$backup.Attributes += 'Hidden'
	}
	Move-Item -Path $ConfigDestionation -Destination $BackupFolder > $null
}

Copy-Item -Path "${PSScriptRoot}\init.lua" -Destination $ConfigDestionation -Force > $null
