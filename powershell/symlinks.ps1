# Get the directory of the script file
$scriptDir = $PSScriptRoot

# Define the source and destination paths
$sourcePath = Join-Path -Path $scriptDir -ChildPath "..\.config\nvim"
$homePath = [environment]::GetFolderPath("UserProfile")
$destinationPath = Join-Path -Path $homePath -ChildPath "AppData\Local\nvim"

# Output the paths for verification
Write-Host "Source Path: $sourcePath"
Write-Host "Destination Path: $destinationPath"

# Check if the destination already exists
if (Test-Path $destinationPath) {
    Write-Host "The destination folder already exists. Removing it..."
    Remove-Item $destinationPath -Recurse -Force
}

# Create the symbolic link
New-Item -ItemType SymbolicLink -Path $destinationPath -Target $sourcePath

Write-Host "Symbolic link created from $sourcePath to $destinationPath"

