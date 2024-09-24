# Main script that will install the Vault Client
$scriptToRun = {
    $extractFolder = "C:\AutocadLTDeployment"
    
    # Bat file to install the program
    $installBat = Join-Path -Path $extractFolder -ChildPath "Install AutocadLTDeployment.bat"

    # Start process hidden so that it doesn't interfere with user activity
    Start-Process -FilePath $installBat -WindowStyle Hidden -Wait
}

# Function to check folder size
function Get-FolderSize {
    param (
        [string]$folderPath
    )
    $folderSize = (Get-ChildItem -Path $folderPath -Recurse | Measure-Object -Property Length -Sum).Sum
    return $folderSize
}

# Check if the IP is online using ping and folder size condition
function Check-IPAddress {
    # Path that determines if AutoCAD LT is already installed
    $vaultProDeploymentPath = "C:\Program Files\Autodesk\AutoCAD LT 2024"
    
    # Path for the extract folder
    $extractFolder = "C:\AutocadLTDeployment"

    # Check if AutoCAD LT is already installed
    if (Test-Path $vaultProDeploymentPath) {
        Write-Host "AutoCAD LT 2024 is already installed."
        return  # Exit if it's already installed
    }

    # Check if the extract folder exists
    if (Test-Path $extractFolder) {
        # Check if the folder size is greater than 3GB (3,000,000,000 bytes)
        $folderSize = Get-FolderSize -folderPath $extractFolder
        if ($folderSize -gt 2700000000) {
            Write-Host "Folder size is greater than 3GB. Proceeding with the script..."
            & $scriptToRun  # Run the installation script if the folder size condition is met
        } else {
            Write-Host "Folder size is less than 3GB. Skipping the script."
        }
    } else {
        Write-Host "Extract folder does not exist."
    }
}

# Run the Check-IPAddress function
Check-IPAddress
