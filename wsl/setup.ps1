$root = wsl wslpath -u $PSScriptRoot.Replace('\', '\\')

wsl cp "${root}/.bashrc" ~/.bashrc