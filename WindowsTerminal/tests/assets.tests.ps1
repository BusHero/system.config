BeforeDiscovery {
	$files = Get-ChildItem `
		-Path "${PSScriptRoot}\..\resources\assets"
}

Describe '<_>' -ForEach $files {
	BeforeAll {
		$path = $_
		$name = Split-Path -Path $path -Leaf
		$destinationPath = "$($env:USERPROFILE)\.config\WindowsTerminal\${name}"
	}

	It 'Exists' {
		$destinationPath | Should -Exist
	}

	It 'right file' {
		$hash1 = Get-FileHash -Path $path
		$hash2 = Get-FileHash -Path $destinationPath
		$hash1.Hash | Should -Be $hash2.Hash -Because "${path} and ${destinationPath} should have same content"
	}
}
