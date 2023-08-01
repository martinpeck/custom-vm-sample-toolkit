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

# Azure Storage Explorer
$StorageExplorer_INSTALLER_FILE="StorageExplorer.exe"
$StorageExplorer_DOWNLOAD_URL="https://go.microsoft.com/fwlink/?LinkId=708343&clcid=0x809"
$StorageExplorer_INSTALL_PATH="$INSTALL_DIRECTORY\StorageExplorer"
$StorageExplorer_INSTALL_ARGS="/VERYSILENT /NORESTART /ALLUSERS /DIR=$StorageExplorer_INSTALL_PATH"

Write-Log "Downloading Azure Storage Explorer installer..."
Invoke-WebRequest -Uri $StorageExplorer_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$StorageExplorer_INSTALLER_FILE"

Write-Log "Installing Azure Storage Explorer..."
Start-Process $StorageExplorer_INSTALLER_FILE -ArgumentList $StorageExplorer_INSTALL_ARGS -Wait

Write-Log "add_storage_explorer script completed"