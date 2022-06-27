function Set-Profile {
	param (
		[string]$BaseProfile,
		[string]$SpecificProfile
	)
	New-Item $SpecificProfile -Force | Out-Null
	Out-File -InputObject ". ${BaseProfile}" -FilePath $SpecificProfile -Force | Out-Null		
}

$ProfilePath = "${PSScriptRoot}\powershell\profile.ps1"

# Set up PowerShell profiles
Set-Profile -BaseProfile $ProfilePath -SpecificProfile "${env:USERPROFILE}\Documents\PowerShell\profile.ps1"
Set-Profile -BaseProfile $ProfilePath -SpecificProfile "${env:USERPROFILE}\Documents\WindowsPowerShell\profile.ps1"

# Set up windows terminal profile
Copy-Item -Path .\WindowsTerminal\settings.json -Destination C:\Users\petru.cervac\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Force