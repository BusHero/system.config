$ParkerNvimPath = "${env:LOCALAPPDATA}\nvim-data\site\pack\packer\start\packer.nvim"

if (Test-Path $ParkerNvimPath) {
	Write-Host 'packer.nvim is already installed'
} else {
	Write-Host 'Installing packer.nvim'
	git clone https://github.com/wbthomason/packer.nvim $PargetNvimPath
}
