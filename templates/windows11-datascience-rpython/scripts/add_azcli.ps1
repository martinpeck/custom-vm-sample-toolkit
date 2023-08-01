function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"

$AZCLI_INSTALLER_FILE="AzureCLI.msi"
$AZCLI_DOWNLOAD_URL="https://aka.ms/installazurecliwindows"
$AZCLI_INSTALL_ARGS="/I $BUILD_DIRECTORY\$AZCLI_INSTALLER_FILE /qn /norestart"

Write-Log "Downloading Azure CLI installer"
Invoke-WebRequest -Uri $AZCLI_DOWNLOAD_URL -OutFile $BUILD_DIRECTORY\$AZCLI_INSTALLER_FILE

Write-Log "Installing Azure CLI"
Start-Process msiexec.exe -Wait -ArgumentList "$AZCLI_INSTALL_ARGS"

Write-Log "add_azcli script completed"