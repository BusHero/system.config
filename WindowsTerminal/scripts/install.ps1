if (Get-Command `
		-Name 'wt' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	return
}

if (Get-Command -Name 'winget' -ErrorAction Ignore -WarningAction Ignore) {
	winget install -e --id Microsoft.WindowsTerminal
}
elseif (Get-Command -Name 'choco' -ErrorAction Ignore -WarningAction Ignore) {
	choco install microsoft-windows-terminal
}
elseif (Get-Command -Name 'scoop' -ErrorAction Ignore -WarningAction Ignore) {
	scoop bucket add extras
	scoop install windows-terminal
}
else {
	Add-AppxPackage 'Microsoft.WindowsTerminal_Win10_1.15.3465.0_8wekyb3d8bbwe.msixbundle'
	Import-Module Appx -UseWindowsPowerShell
}
