#!/bin/bash

# This script installs Visual Studio Code, npm (Node.js), NVM, Docker, and DDEV on a Debian-based system.
# Ensure you run it as root or with sudo privileges.

# Update package list
echo "Updating package list..."
sudo apt update

# Install required dependencies (curl, apt-transport-https, and gpg)
echo "Installing required dependencies..."
sudo apt install curl apt-transport-https gpg lsb-release -y

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
sudo apt remove docker docker-engine docker.io containerd runc -y  # Remove old versions
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

# Install DDEV (a local Docker-based development environment)
echo "Installing DDEV..."
curl -fsSL https://github.com/drud/ddev/releases/download/v1.21.0/ddev_linux.v1.21.0.tar.gz | sudo tar -xz -C /usr/local/bin

# Verify the installation of Docker, DDEV, Node.js and npm
echo "Verifying installations..."
docker --version
ddev --version
node -v
npm -v

# Final message
echo "Visual Studio Code, npm, NVM, Docker, and DDEV installation are complete!"
echo "You can now use VS Code with the 'code' command, manage Node.js versions with NVM, run Docker containers, and use DDEV for local development environments."
