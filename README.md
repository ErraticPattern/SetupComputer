This README file contains code that should be manually executed by the user based on the operating system of their machine. It serves as an entrypoint to the automated procedure of installing apps and applying configurations. Each OS contains a series of steps guiding the user trough the whole procedure.

# Windows 11

1. **Open PowerShell**:
   - Press **Win + X** and select **Windows PowerShell (Admin)** to open PowerShell with administrative privileges.

2. **Run the Script**:
   - Copy and paste the following script into PowerShell:

   ```powershell
   & {
   $userfolder = "$env:USERPROFILE"
   $repoUrl = "https://github.com/ErraticPattern/SetupComputer"
   $targetDir = "$userfolder\git\ErraticPattern"

   if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
       Write-Host "Git is not installed. Installing Git using winget..."
       winget install --id Git.Git -e --source winget
       Write-Host "Git has been installed successfully."
   } else {
       Write-Host "Git is already installed."
   }

   Write-Host "Creating directories..."
   New-Item -Path "$userfolder\git" -ItemType Directory -Force
   New-Item -Path $targetDir -ItemType Directory -Force

   Write-Host "Cloning repository..."
   git clone $repoUrl $targetDir
   Write-Host "Repository cloned successfully to $targetDir"

   $windows11Folder = "$targetDir\windows11"
   if (Test-Path "$windows11Folder\setup.bat") {
       Write-Host "Executing setup.bat in Windows11 folder..."
       Start-Process -FilePath "$windows11Folder\setup.bat" -Wait
       Write-Host "Setup completed."
   } else {
       Write-Host "setup.bat not found in the Windows11 folder."
   }
   }
   ```

# Linux

# MacOS
