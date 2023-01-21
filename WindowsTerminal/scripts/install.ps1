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
	Import-Module Appx -UseWindowsPowerShell
	$temp = New-TemporaryFile
	Invoke-WebRequest `
		-Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx `
		-OutFile $temp.FullName
	Add-AppxPackage -Path $temp.FullName
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
