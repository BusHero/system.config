FROM bus1hero/winget

SHELL ["powershell"]

RUN Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Install-PackageProvider -Name NuGet -Force; \
	Install-Module Pester -Force -SkipPublisherCheck; \
	Import-Module Pester 

COPY . 'C:\\scripts'

WORKDIR 'C:\\scripts'

CMD powershell -NoLogo