function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"
$INSTALL_DIRECTORY="C:\Software"
$SETTINGS_FILE="$BUILD_DIRECTORY\bash_settings.inf"

# Git Bash
$GitBash_INSTALLER_FILE="Git-2.40.0-64-bit.exe"
$GitBash_DOWNLOAD_URL="https://github.com/git-for-windows/git/releases/download/v2.40.0.windows.1/$GitBash_INSTALLER_FILE"
$GitBash_INSTALL_ARGS="/NORESTART /VERYSILENT /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /LOG=$BUILD_DIRECTORY\git-for-windows.log /LOADINF=$SETTINGS_FILE /SUPPRESSMSGBOXES /ALLUSERS"

Write-Log "Creating GitBash Settings file"

"[Setup]
Lang=default
Dir=C:\Program Files\Git
Group=Git
NoIcons=0
SetupType=compact
Components=icons,icons\desktop,ext,ext\shellhere,ext\guihere,gitlfs,assoc,assoc_sh
Tasks=
EditorOption=VIM
CustomEditorPath=
DefaultBranchOption=main
PathOption=Cmd
SSHOption=OpenSSH
TortoiseOption=false
CURLOption=OpenSSL
CRLFOption=CRLFAlways
BashTerminalOption=MinTTY
GitPullBehaviorOption=Merge
UseCredentialManager=Enabled
PerformanceTweaksFSCache=Enabled
EnableSymlinks=Disabled
EnableBuiltinInteractiveAdd=Disabled
PrivilegesRequiredOverridesAllowed=commandline
EnablePseudoConsoleSupport=Disabled
EnableFSMonitor=Disabled" | Out-File -FilePath $SETTINGS_FILE -Force

Write-Log "Downloading Git Bash"
Invoke-WebRequest -Uri $GitBash_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$GitBash_INSTALLER_FILE"

Write-Log "Installing Git Bash"
Start-Process "$BUILD_DIRECTORY\$GitBash_INSTALLER_FILE" -ArgumentList $GitBash_INSTALL_ARGS -Wait

$GitHub_INSTALLER_FILE="GitHubDesktopSetup-x64.msi"
$GitHub_DOWNLOAD_URL="https://central.github.com/deployments/desktop/desktop/latest/win32?format=msi"
$GitHub_INSTALL_ARGS="/I $BUILD_DIRECTORY\$GitHub_INSTALLER_FILE /qn /norestart"

Write-Log "Downloading GitHub Desktop Deployment Tool"
Invoke-WebRequest -Uri "$GitHub_DOWNLOAD_URL" -OutFile "$BUILD_DIRECTORY\$GitHub_INSTALLER_FILE"

Write-Log "Installing Github Desktop Deployment Tool"
Start-Process msiexec.exe -Wait -ArgumentList "$GitHub_INSTALL_ARGS"

Write-Log "add_git script complete."