FROM mcr.microsoft.com/powershell

SHELL ["powershell"]

RUN Install-PackageProvider -Name NuGet -Force
RUN Install-Module Pester -Force -SkipPublisherCheck
RUN Import-Module Pester

CMD powershell -NoLogo