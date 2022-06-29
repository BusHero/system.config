function Set-Profile {
	param (
		[string]$BaseProfile,
		[string]$SpecificProfile
	)
	New-Item $SpecificProfile -Force | Out-Null
	Out-File -InputObject ". ${BaseProfile}" `
			 -FilePath $SpecificProfile `
			 -Force | Out-Null		
}

$ProfilePath = "${PSScriptRoot}\profile.ps1"

Set-Profile -BaseProfile $ProfilePath `
			-SpecificProfile "${env:USERPROFILE}\Documents\PowerShell\profile.ps1"
Set-Profile -BaseProfile $ProfilePath `
			-SpecificProfile "${env:USERPROFILE}\Documents\WindowsPowerShell\profile.ps1"
