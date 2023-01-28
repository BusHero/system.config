if (!(Get-Command -Name nuke -ErrorAction Ignore -WarningAction Ignore)) {
	dotnet tool install -g nuke.GlobalTool
}
