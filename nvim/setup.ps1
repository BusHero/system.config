function New-BackupFile([string] $File) {
	$item = Get-Item -Path $File
	$backup = "$($item.BaseName)_$(Get-Date -Format "yyyyMMdd_HHmmss")$($item.Extension)"

	Write-Host 'Moving ' -NoNewline
	Write-Host $File -ForegroundColor Blue -NoNewline
	Write-Host ' to ' -NoNewline
	Write-Host $backup -ForegroundColor Blue -NoNewline
	Rename-Item `
		-Path $File `
		-NewName $backup

	Write-Host ' ✅ Done' -ForegroundColor Green
}

function New-SymbolicLinkWithBackup(
	[string] $File,
	[string] $Target) {

	switch (Get-Item -Path $File -ErrorAction Ignore) {
		{ $_.LinkType -eq 'SymbolicLink' -and $_.LinkTarget -eq $Target } { return; }
		{ $_.Exists } { New-BackupFile -File $File }
	}

	Write-Host "Link " -NoNewline
	Write-Host $File -ForegroundColor Blue -NoNewline
	Write-Host ' to ' -NoNewline
	Write-Host $Target -ForegroundColor Blue -NoNewline
	New-Item `
		-Path $File `
		-ItemType SymbolicLink `
		-Target $Target `
		-Force `
		> $null
	Write-Host ' ✅ Done' -ForegroundColor Green
}

New-SymbolicLinkWithBackup `
	-File "$($env:USERPROFILE)\AppData\Local\nvim\init.lua" `
	-Target "${PSScriptRoot}\resources\init.lua"

New-SymbolicLinkWithBackup `
	-File "$($env:USERPROFILE)\AppData\Local\nvim\lua\config\lazy.lua" `
	-Target "${PSScriptRoot}\resources\lazy.lua"

New-SymbolicLinkWithBackup `
	-File "$($env:USERPROFILE)\AppData\Local\nvim\lua\plugins" `
	-Target "${PSScriptRoot}\resources\plugins"
