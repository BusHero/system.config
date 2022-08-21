FROM mcr.microsoft.com/powershell

ENV SCOOP "C:\scoop"
ENV SCOOP_HOME "C:\scoop\apps\scoop\current"

SHELL ["powershell"]
RUN Invoke-RestMethod get.scoop.sh -outfile install.ps1
RUN .\install.ps1 -RunAsAdmin
RUN Remove-Item -Path install.ps1

RUN Install-PackageProvider -Name NuGet -Force
RUN Install-Module Pester -Force -SkipPublisherCheck
RUN Import-Module Pester

CMD powershell -NoLogo