#!/bin/bash
#
# ====================== Install Docker Compose ======================

# testing (change to set -xeou pipefail for testing)
set +xeou pipefail

# define variables
SUDO='sudo'

# Update ubuntu
echo " 🛠️ Updating Ubuntu packages..."
$SUDO apt update
echo ""

# Install Git
$SUDO apt install git -y

# check if docker-compose is installed
docker_compose(){
    echo "Checking if Docker Compose is installed..."
    if command -v docker-compose >/dev/null 2>&1; then
        echo "Docker Compose is already installed"
    else
        echo "Docker Compose is not installed, starting installation..."
        $SUDO curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
        $SUDO apt install docker-compose -y
    fi
}

# call docker-compose function
docker_compose

# Apply executable permissions to the binary
$SUDO chmod +x /usr/local/bin/docker-compose

# Check Docker Compose version
echo " 📦 Checking Docker Compose version..."
docker-compose version



# For running the script

# Make the Script Executable:    chmod +x docker_install.sh
# Run the Script                 ./docker_install.sh



# ================================== end of script ===============================