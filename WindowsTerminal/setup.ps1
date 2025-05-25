# & "${PSScriptRoot}\scripts\install.ps1"
# & "${PSScriptRoot}\scripts\sync.ps1"

function New-BackupFile([string] $File) {
	if (-not(Test-Path -Path $File)) {
		return
	}
	$backup = "${File}_$(Get-Date -Format "yyyyMMdd_HHmmss")"

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
	New-BackupFile -File $File

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
	-File "$($env:LOCALAPPDATA)\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json" `
	-Target "${PSScriptRoot}\resources\settings.json"
New-SymbolicLinkWithBackup `
	-File "$($env:LOCALAPPDATA)\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" `
	-Target "${PSScriptRoot}\resources\settings.json"
