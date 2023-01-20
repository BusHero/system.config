if (Get-Command -Name 'oh-my-posh' -ErrorAction Ignore) {
	return
}

if (Get-Command -Name 'winget' -ErrorAction Ignore) {
	winget install JanDeDobbeleer.OhMyPosh -s winget
}
elseif (Get-Command -Name 'scoop' -ErrorAction Ignore) {
	scoop install 'https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json'
}
else {
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
	[System.Environment]::SetEnvironmentVariable('Path', $env:Path, 'user')

	$path = [System.Environment]::GetEnvironmentVariable('Path', 'user')
	if (Test-Path "$(${env:ProgramFiles(x86)})\oh-my-posh") {
		$ohmyposhPath = ";$(${env:ProgramFiles(x86)})\oh-my-posh\bin"
	}
	elseif (Test-Path "$($env:LOCALAPPDATA)\Programs\oh-my-posh") {
		$ohmyposhPath = ";$($env:LOCALAPPDATA)\Programs\oh-my-posh\bin"
	}

	[System.Environment]::SetEnvironmentVariable('Path', "${path};${ohmyposhPath}", 'User')
	[System.Environment]::SetEnvironmentVariable('Path', "${path};${ohmyposhPath}", 'Process')
	$env:Path += $ohmyposhPath
}
