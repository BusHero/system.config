Write-Host setup.ps1

function New-BackupFile([string] $File) {
	if (-not(Test-Path -Path $File)) {
		return
	}
    
    $item = Get-Item -Path $File
	$backupFileName = "$($item.BaseName)_$(Get-Date -Format "yyyyMMdd_HHmmss")$($item.Extension)"
    $backup = Join-Path `
        -Path $item.DirectoryName `
        -ChildPath $backupFileName

    Write-Host 'Moving ' -NoNewline
	Write-Host $File -ForegroundColor Blue -NoNewline
	Write-Host ' to ' -NoNewline
	Write-Host $backup -ForegroundColor Blue -NoNewline
	
    Move-Item `
		-Path $File `
		-Destination $backup `
		> $null

	Write-Host ' ✅ Done' -ForegroundColor Green
}

function New-SymbolicLinkWithBackup(
	[string] $File,
	[string] $Target) {

    $fileAbsolutePath = $File
    $targetAbsolutePath = Resolve-Path -Path $Target

    New-BackupFile -File $fileAbsolutePath
	Write-Host "Link " -NoNewline
	Write-Host $fileAbsolutePath -ForegroundColor Blue -NoNewline
	Write-Host ' to ' -NoNewline
	
    Write-Host $targetAbsolutePath -ForegroundColor Blue -NoNewline
    New-Item `
		-Path $fileAbsolutePath `
		-ItemType SymbolicLink `
		-Target $targetAbsolutePath `
		-Force `
		> $null
	Write-Host ' ✅ Done' -ForegroundColor Green
}

write-host $PROFILE.CurrentUserAllHosts

New-SymbolicLinkWithBackup `
    -File $PROFILE.CurrentUserAllHosts `
    -Target profile.ps1
