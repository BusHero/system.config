if (Get-Command 'pwsh' -ErrorAction Ignore) {
	return
}

choco install powershell-core -y -d -v
