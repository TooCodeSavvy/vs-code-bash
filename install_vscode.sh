#!/bin/bash

# This script installs Visual Studio Code, npm (Node.js), NVM, Docker, and DDEV on a Debian-based system.
# Ensure you run it as root or with sudo privileges.

# Update package list
echo "Updating package list..."
sudo apt update

# Install required dependencies (curl, apt-transport-https, and gpg)
echo "Installing required dependencies..."
sudo apt install -y curl apt-transport-https gpg lsb-release ca-certificates

# Add Microsoft's GPG key to verify package authenticity
echo "Adding Microsoft's GPG key..."
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null

# Add the Visual Studio Code repository to the apt sources list
echo "Adding Visual Studio Code repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

# Update package list again to include the VS Code repository
echo "Updating package list with VS Code repository..."
sudo apt update

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
sudo apt install -y code

# Install Node.js and npm via apt
echo "Installing Node.js and npm..."
sudo apt install -y nodejs npm

# Install NVM (Node Version Manager) to manage multiple Node.js versions
echo "Installing NVM (Node Version Manager)..." 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash 

# Load NVM into the shell session
echo "Loading NVM into shell session..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install the latest Node.js version using NVM
echo "Installing the latest Node.js version via NVM..."
nvm install node

# Install Docker
echo "Installing Docker..."
sudo apt remove -y docker docker-engine docker.io containerd runc  # Remove old versions
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key and repository
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update and install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Install DDEV
echo "Installing DDEV..."
wget https://github.com/ddev/ddev/releases/download/v1.24.3/ddev_1.24.3_linux_amd64.deb
sudo dpkg -i ddev_1.24.3_linux_amd64.deb

# Fix dependencies if needed
sudo apt-get install -f -y

# Remove downloaded .deb file to clean up
rm ddev_1.24.3_linux_amd64.deb

# Verify the installation of Docker, DDEV, Node.js, and npm
echo "Verifying installations..."
docker --version
ddev --version
node -v
npm -v

# Final message
echo "✅ Installation complete!"
echo "You can now use:"
echo "- Visual Studio Code: Run 'code'"
echo "- Node.js & npm: Use 'node -v' and 'npm -v'"
echo "- NVM: Manage Node.js versions with 'nvm'"
echo "- Docker: Check with 'docker --version'"
echo "- DDEV: Run 'ddev' to see available commands"
