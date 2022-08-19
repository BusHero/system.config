$config = New-PesterConfiguration
$config.Run.Path = 'C:\scripts'
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = 'C:\results\results.xml'
$config.TestResult.OutputFormat = 'NUnitXml'

Invoke-Pester -Configuration $config