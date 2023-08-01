function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"

$FIREFOX_INSTALLER_FILE="FIREFOX_installer.exe"
$FIREFOX_DOWNLOAD_URL="https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-GB"
$FIREFOX_INSTALL_ARGS="/s"

Write-Log "Downloading FIREFOX installer..."
Invoke-WebRequest -Uri $FIREFOX_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$FIREFOX_INSTALLER_FILE"

Write-Log "Installing FIREFOX..."
Start-Process "$BUILD_DIRECTORY\$FIREFOX_INSTALLER_FILE" -ArgumentList $FIREFOX_INSTALL_ARGS -Wait

Write-Log "add_firefox script completed"