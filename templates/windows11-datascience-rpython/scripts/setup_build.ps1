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