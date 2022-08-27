$ConfigPath = 'C:\.config'
$GitPath = 'C:\Program Files\Git\cmd\git.exe'

Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install nodejs -y
choco install neovim -y
choco install vscode -y
choco install powershell-core -y
choco install git -y
choco install Firefox -y
choco install gh -y

if (Test-Path -Path $ConfigPath) {
	& $GitPath --work-dir=$ConfigPath pull
}
else {
	& $GitPath clone 'https://github.com/BusHero/system.config.git' $ConfigPath
}

& "${ConfigPath}\setup.ps1"