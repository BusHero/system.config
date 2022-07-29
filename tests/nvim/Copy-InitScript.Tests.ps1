BeforeAll {
	function script:Copy-InitScript {
		. "$(Get-ScriptPath -Path $PSCommandPath -SourceDirectory '')" @args
	}
}

Describe 'parent directory' {
	Describe "create parent directory if it doesn't exist" {
		BeforeAll {
			$path = "${TestDrive}\this\path\does\not\exists"
			Mock-EnvironmentVariable -Variable XDG_CONFIG_HOME -Value $path -Fixture {
				Copy-InitScript
			}
		}
		It 'init.lua is copied to the right location' {
			"${path}\nvim\init.lua" | Should -Exist
		}
	}

	Describe 'Do not override parent directory' {
		BeforeAll {
			$path = "${TestDrive}\this\directory\does\exists"
			$file = "${path}\nvim\foo.txt"
			New-Item -Path $file -ItemType File -Force > $null
			Mock-EnvironmentVariable -Variable XDG_CONFIG_HOME -Value $path -Fixture {
				Copy-InitScript
			}
		}

		It '<file> exists' {
			$file | Should -Exist
		}

		It 'init.lua is copied to the right location' {
			"${path}\nvim\init.lua" | Should -Exist
		}
	}
}
