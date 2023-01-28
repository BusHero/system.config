if (! (Get-Command -Name csharprepl -ErrorAction Ignore -WarningAction Ignore)) {
	dotnet tool install -g csharprepl
}
