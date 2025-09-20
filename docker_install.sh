#!/bin/bash
#
# ============================ docker installation ============================
#
# testing (change to set -xeou pipefail for testing)
set +xeou pipefail

# define variables
SUDO='sudo'

echo " 🚀 Installation of Docker started"
echo ""

# Update ubuntu
echo " 🛠️ Updating Ubuntu packages..."
$SUDO apt update
echo ""

# Install required packages
# echo " 📦 Installing required packages..."
# $SUDO apt install apt-transport-https ca-certificates curl software-properties-common -y
# echo ""

# # Add Docker’s official GPG key
# echo " 🔑 Adding Docker’s official GPG key..."
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | $SUDO apt-key add -
# echo ""

# # Add Docker repository
# echo " 📦 Adding Docker repository..."
# $SUDO add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# echo ""

# # Update the package list
# echo " 🛠️ Updating package list..."
# $SUDO apt update
# echo ""

# function to install docker
install_docker(){
    echo "✅ Installing Docker..."
    if command -v docker >/dev/null 2>&1; then
        echo "Docker is alreaady installed"
    else
        echo "🚫 Docker is not installed, starting installation..."
        $SUDO apt install docker.io -y
        echo ""
    fi
}

# call docker function
install_docker

# Start Docker service
echo " 🔄 Starting Docker service..."
$SUDO systemctl start docker
echo ""

# Enable Docker to start at boot
echo " 🔧 Enabling Docker to start at boot..."
$SUDO systemctl enable docker
echo ""

# Allow non-root users to run Docker commands
$SUDO chmod 666 /var/run/docker.sock

# Add user to the Docker group
$SUDO usermod -aG docker $USER && newgrp docker


echo " 🎉 Docker installation completed."
echo "Docker version:"
$SUDO docker --version



# For running the script

# Make the Script Executable:    chmod +x docker_install.sh
# Run the Script                 ./docker_install.sh



# ================================== end of script ===============================