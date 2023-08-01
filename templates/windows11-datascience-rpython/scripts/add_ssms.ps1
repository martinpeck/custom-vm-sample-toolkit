function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"
$INSTALL_DIRECTORY="C:\Software"

$SSMS_INSTALLER_FILE="SSMS-Setup-ENU.exe"
$SSMS_DOWNLOAD_URL="https://aka.ms/ssmsfullsetup"
$SSMS_INSTALL_ARGS="/INSTALL /QUIET SSMSInstallRoot=$INSTALL_DIRECTORY"

# Write-Log "Downloading SSMS installer"
# Invoke-WebRequest $SSMS_DOWNLOAD_URL -OutFile $BUILD_DIRECTORY\$SSMS_INSTALLER_FILE

Write-Log "Installing SSMS"
Start-Process "$BUILD_DIRECTORY\$SSMS_INSTALLER_FILE" -ArgumentList $SSMS_INSTALL_ARGS -Wait