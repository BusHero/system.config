using namespace System.Management.Automation
using namespace System.Management.Automation.Language


function IsVirtualTerminalProcessingEnabled {
	$MethodDefinitions = @'
[DllImport("kernel32.dll", SetLastError = true)]
public static extern IntPtr GetStdHandle(int nStdHandle);
[DllImport("kernel32.dll", SetLastError = true)]
public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);
'@
	$Kernel32 = Add-Type `
		-MemberDefinition $MethodDefinitions `
		-Name 'Kernel32' `
		-Namespace 'Win32' `
		-PassThru
	$hConsoleHandle = $Kernel32::GetStdHandle(-11)
	$mode = 0
	$Kernel32::GetConsoleMode($hConsoleHandle, [ref]$mode) >$null
	if ($mode -band 0x0004) {
		return $true
	}
	return $false
}

function CanUsePredictionSource {
	return (! [System.Console]::IsOutputRedirected) -and (IsVirtualTerminalProcessingEnabled)
}

New-Alias -Name touch -Value New-Item

if ($host.Name -eq 'ConsoleHost') {
	Import-Module PSReadLine
}
Import-Module -Name Terminal-Icons

oh-my-posh `
	--init `
	--shell pwsh `
	--config "$($env:USERPROFILE)\.config\ohmyposh\settings.json" | Invoke-Expression


if (CanUsePredictionSource) {
	switch (Get-Module PSReadLine | Select-Object -ExpandProperty Version) {
		{ $_ -gt '2.2' } {
			Set-PSReadLineOption `
				-PredictionSource History `
				-PredictionViewStyle ListView `
				-WarningAction Ignore `
				-ErrorAction Ignore
			break
		}
		{ $_ -gt '2.1' } {
			Set-PSReadLineOption `
				-PredictionSource History `
				-ErrorAction Ignore `
				-WarningAction Ignore
			break
		}
	}
	Set-PSReadLineOption -EditMode Windows
}

. "${PSScriptRoot}\ProfileScripts\keymappings.ps1"
. "${PSScriptRoot}\ProfileScripts\autocompletion.ps1"
