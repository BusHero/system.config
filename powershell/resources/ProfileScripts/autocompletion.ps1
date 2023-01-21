# Set up nuke auto completion
Register-ArgumentCompleter -Native -CommandName nuke -ScriptBlock {
	param($commandName, $wordToComplete, $cursorPosition)
	nuke :complete "$wordToComplete" | ForEach-Object {
		[System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
	}
}

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
	param($commandName, $wordToComplete, $cursorPosition)
	dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
		[System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
	}
}



# PowerShell parameter completion shim for the GitHub CLI
gh completion -s powershell | Out-String | Invoke-Expression


Import-Module -Name posh-git
