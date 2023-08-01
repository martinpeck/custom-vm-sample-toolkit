# Templates

Create one sub-folder per customizer VM image template.

## basic-linux
The basic-linux template is just that...pretty much a standard Ubuntu linux image, but demonstrating a small customisation via a bash script.


## basic-windows
Contains a vanilla image of Windows 11 Pro 21h2. Use this template as a template
for building customised images. Although the basic-windows template contains
a customisation script in the `scripts` folder, this is not reference in the 
image_template.json, and is therefore not used when defining a building the 
image. However, you can build the image, and use this to test that the `init_vm.sh`
script will run correctly before it in your customised images. 

Once you have tested the script on a vanilla Windows 11 build, 
you can add your customisation scripts into the build of your customised windows image. 
Just add a `customize` section to your image_template.json:

      "customize": [
        {
            "type": "PowerShell",
            "name": "CreateBuildPath",
            "runElevated": false,
            "scriptUri": "https://<scriptStorageAcc>.blob.core.windows.net/<scriptStorageAccContainer>/basic-windows/scripts/init_vm.ps1"
        },
        {
            "type": "WindowsRestart",
            "restartCheckCommand": "echo Azure-Image-Builder-Restarted-the-VM  > c:\\BuildArtifacts\\azureImageBuilderRestart.txt",
            "restartTimeout": "5m"
        }
    ],

**Remember to change `basic-windows` in the scriptUri to match the name of your custom image folder**

