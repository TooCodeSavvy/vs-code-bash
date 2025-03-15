#!/bin/bash

# This script installs Visual Studio Code on a Debian-based system.
# Ensure you run it as root or with sudo privileges.

# Update package list
echo "Updating package list..."
sudo apt update

# Install required dependencies (curl, apt-transport-https, and gpg)
echo "Installing required dependencies..."
sudo apt install curl apt-transport-https gpg -y

# Add Microsoft's GPG key to verify package authenticity
echo "Adding Microsoft's GPG key..."
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null

# Add the Visual Studio Code repository to the apt sources list
echo "Adding Visual Studio Code repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

# Update the package list again to include the VS Code repository
echo "Updating package list with VS Code repository..."
sudo apt update

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
sudo apt install code -y

# Final message
echo "Visual Studio Code installation is complete!"
