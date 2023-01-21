if (Get-Command `
		-Name 'choco' `
		-ErrorAction Ignore `
		-WarningAction Ignore) {
	return
}

Set-ExecutionPolicy `
	-ExecutionPolicy Bypass `
	-Scope Process `
	-Force

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

Invoke-WebRequest -Uri 'https://community.chocolatey.org/install.ps1' | `
	Select-Object -ExpandProperty Content | `
	Invoke-Expression
