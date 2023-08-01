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

# ANACONDA
$ANACONDA_INSTALLER_FILE="Anaconda3-2022.05-Windows-x86_64.exe"
$ANACONDA_DOWNLOAD_URL="https://repo.anaconda.com/archive/$ANACONDA_INSTALLER_FILE"
$ANACONDA_INSTALL_PATH="$INSTALL_DIRECTORY\Anaconda3"
$ANACONDA_INSTALL_ARGS="/InstallationType=AllUsers /RegisterPython=0 /S /D=$ANACONDA_INSTALL_PATH"

Write-Log "Downloading Anaconda installer..."
Invoke-WebRequest -Uri $ANACONDA_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$ANACONDA_INSTALLER_FILE"

Write-Log "Installing Anaconda..."
Start-Process $ANACONDA_INSTALLER_FILE -ArgumentList $ANACONDA_INSTALL_ARGS -Wait

# PATH
Write-Log "Add Anaconda to PATH environment variable"
[Environment]::SetEnvironmentVariable("PATH", "$Env:PATH;$ANACONDA_INSTALL_PATH\condabin", [EnvironmentVariableTarget]::Machine)


Write-Log "add_anaconda script completed"