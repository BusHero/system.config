FROM mcr.microsoft.com/powershell:nanoserver-20h2
ARG NVIM_VERSION='0.7.2'

ADD "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-win64.zip" nvim.zip
RUN pwsh -command 'Expand-Archive -Path .\nvim.zip -DestinationPath "C:\Program Files\nvim"'
RUN del nvim.zip
RUN pwsh -command "[Environment]::SetEnvironmentVariable('Path', $env:Path + ';C:\AppInstaller', [EnvironmentVariableTarget]::Machine)"
RUN pwsh -command "[Environment]::SetEnvironmentVariable('Path', $env:Path + ';C:\AppInstaller', [EnvironmentVariableTarget]::Machine)"

# RUN C:\Downloads\vcredist_x64.exe /install /passive /norestart /log out.txt
