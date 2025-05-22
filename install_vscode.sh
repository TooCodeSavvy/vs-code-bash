#!/bin/bash

# This script installs Visual Studio Code, npm (Node.js), NVM, Docker, DDEV, PHP 8.4, and Composer on a Debian-based system.
# Ensure you run it as root or with sudo privileges.

# Add Sury's PHP repository to get PHP 8.4
echo "Adding Sury PHP repository..."
sudo apt install -y lsb-release apt-transport-https ca-certificates wget
wget -qO - https://packages.sury.org/php/apt.gpg | sudo tee /usr/share/keyrings/php-sury.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/php-sury.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php-sury.list

# Update package list again after adding new repo
sudo apt update

# Install required dependencies
echo "Installing required dependencies..."
sudo apt install -y curl apt-transport-https gpg lsb-release ca-certificates wget unzip

# Install PHP 8.4 and required extensions
echo "Installing PHP 8.4 and required extensions..."
sudo apt install -y php8.4 php8.4-cli php8.4-mbstring php8.4-zip php8.4-xml php8.4-curl php8.4-gd php8.4-mysql php8.4-bcmath php8.4-tokenizer

# Add Microsoft's GPG key for VS Code
echo "Adding Microsoft's GPG key..."
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null

# Add the Visual Studio Code repository
echo "Adding Visual Studio Code repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

# Update package list again
echo "Updating package list with VS Code repository..."
sudo apt update

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
sudo apt install -y code

# Install Node.js and npm via apt
echo "Installing Node.js and npm..."
sudo apt install -y nodejs npm

# Install NVM (Node Version Manager)
echo "Installing NVM (Node Version Manager)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

# Load NVM into the shell session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \ . "$NVM_DIR/nvm.sh"

# Install the latest Node.js version using NVM
echo "Installing the latest Node.js version via NVM..."
nvm install node

# Install Docker
echo "Installing Docker..."
sudo apt remove -y docker docker.io containerd runc  
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

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

# Add the user to the Docker group
echo "Adding 'developer' to the docker group..."
sudo usermod -aG docker developer

# Install DDEV
echo "Installing DDEV..."
sudo apt-get update && sudo apt-get install -y curl
test -d /etc/apt/keyrings || sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://pkg.ddev.com/apt/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/ddev.gpg > /dev/null
sudo chmod a+r /etc/apt/keyrings/ddev.gpg
echo "deb [signed-by=/etc/apt/keyrings/ddev.gpg] https://pkg.ddev.com/apt/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list > /dev/null
sudo apt-get update && sudo apt-get install -y ddev

# Install Composer
echo "Installing Composer..."
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
HASH=`curl -sS https://composer.github.io/installer.sig`
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Verify Composer installation
echo "Verifying Composer installation..."
composer --version

# Install NVM for the 'developer' user
echo "Installing NVM for the 'developer' user..."
sudo -u developer curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
sudo -u developer bash -c 'export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \ . "$NVM_DIR/nvm.sh" && nvm install node'

# Add NVM config to the new user's .bashrc file
echo "Adding NVM setup to developer's .bashrc..."
echo -e "\n# NVM setup\nexport NVM_DIR=\"$HOME/.nvm\"\n[ -s \"$NVM_DIR/nvm.sh\" ] && \\. \"$NVM_DIR/nvm.sh\"" | sudo tee -a /home/developer/.bashrc

# Final message
echo "✅ Installation complete!"
echo "You can now use:"
echo "- Visual Studio Code: Run 'code'"
echo "- Node.js & npm: Use 'node -v' and 'npm -v'"
echo "- NVM: Manage Node.js versions with 'nvm'"
echo "- Docker: Check with 'docker --version'"
echo "- DDEV: Run 'ddev' to see available commands"
echo "- Composer: Run 'composer --version' to verify installation"
