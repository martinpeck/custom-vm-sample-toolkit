function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"
$INSTALL_DIRECTORY="C:\Software"

$CHROME_INSTALLER_FILE="chrome_installer.exe"
$CHROME_DOWNLOAD_URL="http://dl.google.com/chrome/install/375.126/$CHROME_INSTALLER_FILE"
$CHROME_INSTALL_ARGS="/silent /install"

Write-Log "Downloading CHROME installer..."
Invoke-WebRequest -Uri $CHROME_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$CHROME_INSTALLER_FILE"

Write-Log "Installing Chrome..."
Start-Process "$BUILD_DIRECTORY\$CHROME_INSTALLER_FILE" -ArgumentList $CHROME_INSTALL_ARGS -Wait

Write-Log "add_chrome script completed"