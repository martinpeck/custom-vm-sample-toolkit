function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"
$INSTALL_DIRECTORY="C:\Software"

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

Write-Log "add_python3 script completed"