function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"
$INSTALL_DIRECTORY="C:\Software"

Write-Log "Create Directories"
New-Item -Path $BUILD_DIRECTORY -ItemType Directory
New-Item -Path $INSTALL_DIRECTORY -ItemType Directory

Set-Location -Path $BUILD_DIRECTORY

# Python
$PYTHON_INSTALLER_FILE="python-3.10.7-amd64.exe"
$PYTHON_DOWNLOAD_URL="https://www.python.org/ftp/python/3.10.7/$PYTHON_INSTALLER_FILE"
$PYTHON_INSTALL_PATH="$INSTALL_DIRECTORY\Python3"
$PYTHON_INSTALL_ARGS="/quiet InstallAllUsers=1 PrependPath=1 Include_test=0 TargetDir=$PYTHON_INSTALL_PATH"

Write-Log "Downloading Python3 installer..."
Invoke-WebRequest -Uri $PYTHON_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$PYTHON_INSTALLER_FILE"

Write-Log "Installing Python3..."
Start-Process $PYTHON_INSTALLER_FILE -ArgumentList $PYTHON_INSTALL_ARGS -Wait

# ANACONDA
$ANACONDA_INSTALLER_FILE="Anaconda3-2022.05-Windows-x86_64.exe"
$ANACONDA_DOWNLOAD_URL="https://repo.anaconda.com/archive/$ANACONDA_INSTALLER_FILE"
$ANACONDA_INSTALL_PATH="$INSTALL_DIRECTORY\Anaconda3"
$ANACONDA_INSTALL_ARGS="/InstallationType=AllUsers /RegisterPython=0 /S /D=$ANACONDA_INSTALL_PATH"

Write-Log "Downloading Anaconda installer..."
Invoke-WebRequest -Uri $ANACONDA_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$ANACONDA_INSTALLER_FILE"

Write-Log "Installing Anaconda..."
Start-Process $ANACONDA_INSTALLER_FILE -ArgumentList $ANACONDA_INSTALL_ARGS -Wait

# VSCODE
$VSCODE_INSTALLER_FILE="VSCodeSetup-x64-1.71.2.exe"
$VSCODE_DOWNLOAD_URL="https://update.code.visualstudio.com/1.71.2/win32-x64/stable"
$VSCODE_INSTALL_PATH="$INSTALL_DIRECTORY\VSCode"
$VSCODE_EXTENSION_PATH="$VSCODE_INSTALL_PATH\extensions"
$VSCODE_INSTALL_ARGS="/VERYSILENT /DIR=$VSCODE_INSTALL_PATH /MERGETASKS=!runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"
$VSCODE_INSTALL_PATH="$INSTALL_DIRECTORY\VSCode"

[Environment]::SetEnvironmentVariable("VSCODE_EXTENSIONS", "$VSCODE_EXTENSION_PATH", [EnvironmentVariableTarget]::Machine)

Write-Log "Downloading VSCode system installer..."
Invoke-WebRequest -Uri $VSCODE_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$VSCODE_INSTALLER_FILE"

Write-Log "Installing VSCode..."
Start-Process $VSCODE_INSTALLER_FILE -ArgumentList $VSCODE_INSTALL_ARGS -Wait

Write-Log "Installing VSCode Extensions"
New-Item -Path $VSCODE_EXTENSION_PATH -ItemType Directory
# See https://code.visualstudio.com/docs/editor/command-line#_working-with-extensions
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-python.python --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension REditorSupport.r --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension RDebugger.r-debugger --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-toolsai.vscode-ai-remote --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-toolsai.vscode-ai --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-python.vscode-pylance --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-vscode.PowerShell --force" -Wait

# R
$R_INSTALLER_FILE="R-4.2.3-win.exe"
$R_DOWNLOAD_URL="https://cran.ma.imperial.ac.uk/bin/windows/base/$R_INSTALLER_FILE"
$R_INSTALL_PATH="$INSTALL_DIRECTORY\R"
$R_INSTALL_ARGS="/VERYSILENT /NORESTART /ALLUSERS /DIR=$R_INSTALL_PATH"

Write-Log "Downloading R-Base Package installer..."
Invoke-WebRequest -Uri $R_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$R_INSTALLER_FILE"

Write-Log "Installing R-Base Package..."
Start-Process $R_INSTALLER_FILE -ArgumentList $R_INSTALL_ARGS -Wait

# RTools - This need to be install at the default location to avoid rtools not found errors.
$RTools_INSTALLER_FILE="rtools42-5355-5357.exe"
$RTools_DOWNLOAD_URL="https://cran.r-project.org/bin/windows/Rtools/rtools42/files/$RTools_INSTALLER_FILE"
$RTools_INSTALL_ARGS="/VERYSILENT /NORESTART /ALLUSERS"

Write-Log "Downloading RTools installer..."
Invoke-WebRequest -Uri $RTools_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$RTools_INSTALLER_FILE"

Write-Log "Installing RTools..."
Start-Process $RTools_INSTALLER_FILE -ArgumentList $RTools_INSTALL_ARGS -Wait

# RStudio
$RStudio_INSTALLER_FILE="RStudio-2022.07.2-576.exe"
$RStudio_DOWNLOAD_URL="https://download1.rstudio.org/desktop/windows/$RStudio_INSTALLER_FILE"
$RStudio_INSTALL_PATH="$INSTALL_DIRECTORY\RStudio"
$RStudio_INSTALL_ARGS="/S /D=$RStudio_INSTALL_PATH"

Write-Log "Downloading RStudio Package installer..."
Invoke-WebRequest -Uri $RStudio_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$RStudio_INSTALLER_FILE"

Write-Log "Installing RStudio Package..."
Start-Process $RStudio_INSTALLER_FILE -ArgumentList $RStudio_INSTALL_ARGS -Wait

# Azure Storage Explorer
$StorageExplorer_INSTALLER_FILE="StorageExplorer.exe"
$StorageExplorer_DOWNLOAD_URL="https://go.microsoft.com/fwlink/?LinkId=708343&clcid=0x809"
$StorageExplorer_INSTALL_PATH="$INSTALL_DIRECTORY\StorageExplorer"
$StorageExplorer_INSTALL_ARGS="/VERYSILENT /NORESTART /ALLUSERS /DIR=$StorageExplorer_INSTALL_PATH"

Write-Log "Downloading Azure Storage Explorer installer..."
Invoke-WebRequest -Uri $StorageExplorer_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$StorageExplorer_INSTALLER_FILE"

Write-Log "Installing Azure Storage Explorer..."
Start-Process $StorageExplorer_INSTALLER_FILE -ArgumentList $StorageExplorer_INSTALL_ARGS -Wait

# PATH
Write-Log "Add Anaconda and R to PATH environment variable"
[Environment]::SetEnvironmentVariable("PATH", "$Env:PATH;$ANACONDA_INSTALL_PATH\condabin;$R_INSTALL_PATH\bin;$VSCODE_INSTALL_PATH\bin", [EnvironmentVariableTarget]::Machine)

# Write-Log "Clean up..."
# Set-Location -Path "$INSTALL_DIRECTORY"
# Remove-Item -Force -Path "$BUILD_DIRECTORY"

Write-Log "rpython_init script complete."
