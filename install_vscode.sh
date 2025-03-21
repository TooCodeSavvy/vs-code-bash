#!/bin/bash

# This script installs Visual Studio Code, npm (Node.js), NVM, Docker, and DDEV on a Debian-based system.
# It will also create a new user and add it to the docker group for easier Docker usage.
# Ensure you run it as root or with sudo privileges.

# Update package list
echo "Updating package list..."
sudo apt update

# Install required dependencies (curl, apt-transport-https, and gpg)
echo "Installing required dependencies..."
sudo apt install -y curl apt-transport-https gpg lsb-release ca-certificates wget

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

# Load NVM into the shell session for root user
echo "Loading NVM for root..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install the latest Node.js version using NVM for root user
echo "Installing the latest Node.js version via NVM..."
nvm install node

# Install Docker
echo "Installing Docker..."
sudo apt remove -y docker docker.io containerd runc  
sudo apt update
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key and repository
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update and install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add a new user for Docker and DDEV usage
echo "Creating a new user 'developer'..."
sudo useradd -m -s /bin/bash developer
echo "developer:developer" | sudo chpasswd

# Add the user to the Docker group to allow Docker usage without sudo
echo "Adding 'developer' to the docker group..."
sudo usermod -aG docker developer

# Install DDEV
echo "Downloading DDEV..."

sudo sh -c 'echo ""'
sudo apt-get update && sudo apt-get install -y curl
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://pkg.ddev.com/apt/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/ddev.gpg > /dev/null
sudo chmod a+r /etc/apt/keyrings/ddev.gpg

sudo sh -c 'echo ""'
echo "deb [signed-by=/etc/apt/keyrings/ddev.gpg] https://pkg.ddev.com/apt/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list >/dev/null
sudo apt-get update && sudo apt-get install -y ddev 

# Install NVM for the 'developer' user
echo "Installing NVM for the 'developer' user..."
sudo -u developer curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
sudo -u developer bash -c 'export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install node'

# Add NVM config to the new user's .bashrc file to load NVM automatically
echo "Adding NVM setup to developer's .bashrc..."
echo -e "\n# NVM setup\nexport NVM_DIR=\"$HOME/.nvm\"\n[ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"" | sudo tee -a /home/developer/.bashrc

# Switch to the new user and drop into their shell
echo "Switching to 'developer' user..."
sudo su - developer

# Final message
echo "✅ Installation complete!"
echo "You can now use:"
echo "- Visual Studio Code: Run 'code'"
echo "- Node.js & npm: Use 'node -v' and 'npm -v'"
echo "- NVM: Manage Node.js versions with 'nvm'"
echo "- Docker: Check with 'docker --version'"
echo "- DDEV: Run 'ddev' to see available commands"
