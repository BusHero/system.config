FROM mcr.microsoft.com/powershell

SHELL ["powershell"]

RUN Install-PackageProvider -Name NuGet -Force; \
	Install-Module Pester -Force -SkipPublisherCheck; \
	Import-Module Pester

CMD powershell -NoLogo