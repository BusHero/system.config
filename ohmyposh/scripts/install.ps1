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
}
