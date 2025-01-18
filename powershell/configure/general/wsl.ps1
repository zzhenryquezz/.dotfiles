# Enable the WSL feature
Write-Host "Enabling WSL..."
wsl --install -y

# Set WSL version to 2
Write-Host "Setting WSL version to 2..."
wsl --set-default-version 2

# Enable Virtual Machine Platform feature (required for WSL 2)
Write-Host "Enabling Virtual Machine Platform feature..."
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

# Enable the Windows Subsystem for Linux feature
Write-Host "Enabling Windows Subsystem for Linux feature..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

# Enable Hyper-V feature (required for WSL 2 with virtualization)
Write-Host "Enabling Hyper-V feature..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart

# Prompt for a restart to apply changes
Write-Host "WSL has been enabled. Please restart your computer to apply the changes." -ForegroundColor Green
