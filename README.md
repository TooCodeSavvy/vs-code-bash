Automated Development Environment Setup
=======================================

This repository provides a bash script that automates the installation of essential development tools on a Debian-based system. The script installs the following:

-   **Visual Studio Code (VS Code)**
-   **Node.js and npm**
-   **Node Version Manager (NVM)**
-   **Docker**
-   **DDEV**

It also creates a new user for Docker and DDEV usage and adds the user to the Docker group for easy Docker access without `sudo`.

* * * * *

Requirements
------------

-   A Debian-based system (e.g., Ubuntu).
-   Sudo privileges to run the installation.

* * * * *

Installation
------------

1.  Clone the repository:Automated Development Environment Setup
=======================================

This repository provides a bash script that automates the installation of essential development tools on a Debian-based system. The script installs the following:

-   **Visual Studio Code (VS Code)**
-   **Node.js and npm**
-   **Node Version Manager (NVM)**
-   **Docker**
-   **DDEV**

It also creates a new user for Docker and DDEV usage and adds the user to the Docker group for easy Docker access without `sudo`.

* * * * *

Requirements
------------

-   A Debian-based system (e.g., Ubuntu).
-   Sudo privileges to run the installation.

* * * * *

Installation
------------

1. Clone the repository:
 ```
 git clone https://github.com/TooCodeSavvy/vs-code-bash.git
 cd vs-code-bash
 ```
2. Make the installation script executable:
 ```
 chmod +x install_vscode.sh
 ```
3. Run the script as root to install the necessary tools:
 ```
 sudo ./install_vscode.sh
 ```
Features
------------ 

-   Installs **Visual Studio Code** for a powerful code editor.
-   Installs **Node.js** and **npm** for JavaScript and Node.js development.
-   Installs **NVM** to manage multiple versions of Node.js.
-   Installs **Docker** for containerization.
-   Installs **DDEV** for local development environments.
-   Creates a new user (`developer`) for easier Docker usage and adds it to the Docker group.

* * * * *

Usage
-----

-   You can now use the following tools:

    -   **Visual Studio Code**: `code`
    -   **Node.js & npm**: `node -v` and `npm -v`
    -   **NVM**: `nvm`
    -   **Docker**: `docker --version`
    -   **DDEV**: `ddev`
