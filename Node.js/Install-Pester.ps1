[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
Install-PackageProvider -Name NuGet -Force
Install-Module Pester -Force -SkipPublisherCheck
Import-Module Pester