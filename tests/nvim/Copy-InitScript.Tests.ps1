BeforeAll {
	$ProjectRoot = Get-ProjectRoot -Path $PSScriptRoot -Markers .git
	$config = "${ProjectRoot}\nvim\init.lua"

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
			$Expected = Get-Content -Path $config 
			$Actual = Get-Content "${path}\nvim\init.lua"
			$Actual | Should -Be $Expected
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
		
		It 'init.lua is copied to the right location' {
			$Expected = Get-Content -Path $config 
			$Actual = Get-Content "${path}\nvim\init.lua"
			$Actual | Should -Be $Expected
		}
	}

	Describe 'Backup' {
		BeforeAll {
			$OriginalValue = 'Some value here and there'
			$path = "${TestDrive}\this\directory\does\exists"
			New-Item -Path "${path}\nvim\init.lua" -ItemType File -Value $OriginalValue -Force > $null
			Mock-EnvironmentVariable -Variable XDG_CONFIG_HOME -Value $path -Fixture {
				Copy-InitScript
			}
		}

		It 'Backuped file should have the same content' {
			"${path}\nvim\.backup\init.lua" | Should -FileContentMatch $OriginalValue
		}

		It 'Make .backup a hidden folder' {
			(Get-Item "${path}\nvim\.backup" -Force).Attributes | Should -Match Hidden
		}
		
		It 'init.lua is copied to the right location' {
			$Expected = Get-Content -Path $config 
			$Actual = Get-Content "${path}\nvim\init.lua"
			$Actual | Should -Be $Expected
		}
	}

	Describe 'Do not change .backup folder if it is already present' {
		BeforeAll {
			$OriginalValue = 'Some value here and there'
			$path = "${TestDrive}\this\directory\does\exists"
			New-Item -Path "${path}\nvim\init.lua" -ItemType File -Value $OriginalValue -Force > $null
			New-Item -Path "${path}\nvim\.backup" -ItemType Directory -Force > $null
			Mock-EnvironmentVariable -Variable XDG_CONFIG_HOME -Value $path -Fixture {
				Copy-InitScript
			}
		}
		It 'original file is copied to the backup folder' {
			"${path}\nvim\.backup\init.lua" | Should -Exist
		}

		It 'Backuped file should have the same content' {
			"${path}\nvim\.backup\init.lua" | Should -FileContentMatch $OriginalValue
		}

		It 'Make .backup a hidden folder' {
			(Get-Item "${path}\nvim\.backup" -Force).Attributes | Should -Not -Match Hidden
		}

		It 'init.lua is copied to the right location' {
			$Expected = Get-Content -Path $config 
			$Actual = Get-Content "${path}\nvim\init.lua"
			$Actual | Should -Be $Expected
		}
	}

	Describe 'Move .backup file in the .backup folder' {
		BeforeAll {
			$OriginalValue = 'Some value here and there'
			$path = "${TestDrive}\this\directory\does\exists"
			New-Item -Path "${path}\nvim\init.lua" -ItemType File -Value $OriginalValue -Force > $null
			New-Item -Path "${path}\nvim\.backup" -ItemType File -Value $OriginalValue -Force > $null
			Mock-EnvironmentVariable -Variable XDG_CONFIG_HOME -Value $path -Fixture {
				Copy-InitScript
			}
		}

		It 'original file is copied to the backup folder' {
			"${path}\nvim\.backup\.backup" | Should -FileContentMatch $OriginalValue
		}

		It 'Backuped file should have the same content' {
			"${path}\nvim\.backup\init.lua" | Should -FileContentMatch $OriginalValue
		}

		It 'Make .backup a hidden folder' {
			(Get-Item "${path}\nvim\.backup" -Force).Attributes | Should -Match Hidden
		}

		It 'init.lua is copied to the right location' {
			$Expected = Get-Content -Path $config 
			$Actual = Get-Content "${path}\nvim\init.lua"
			$Actual | Should -Be $Expected
		}
	}

	Describe 'Add a number to the backup file if it already exists' {
		BeforeAll {
			$OriginalValue = 'Some value here and there'
			$BackupOriginalValue = 'Some value here and there'
			$path = "${TestDrive}\$(New-Guid)"
			New-Item -Path "${path}\nvim\init.lua" -ItemType File -Value $OriginalValue -Force > $null
			New-Item -Path "${path}\nvim\.backup\init.lua" -ItemType File -Value $BackupOriginalValue -Force > $null
			Mock-EnvironmentVariable -Variable XDG_CONFIG_HOME -Value $path -Fixture {
				Copy-InitScript
			}
		}

		It 'original file is copied to the backup folder' {
			"${path}\nvim\.backup\init.lua" | Should -FileContentMatch $BackupOriginalValue
		}

		It 'original file is copied to the backup folder' {
			"${path}\nvim\.backup\init.1.lua" | Should -FileContentMatch $OriginalValue
		}

		It 'init.lua is copied to the right location' {
			$Expected = Get-Content -Path $config 
			$Actual = Get-Content "${path}\nvim\init.lua"
			$Actual | Should -Be $Expected
		}
	}
}
