#!/bin/bash

# ============================ docker installation ============================

echo " 🚀 Installation of Docker start"
echo ""

# Update ubuntu
echo " 🛠️ Updating Ubuntu packages..."
sudo apt update
echo ""

# Install required packages
# echo " 📦 Installing required packages..."
# sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
# echo ""

# # Add Docker’s official GPG key
# echo " 🔑 Adding Docker’s official GPG key..."
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# echo ""

# # Add Docker repository
# echo " 📦 Adding Docker repository..."
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# echo ""

# # Update the package list
# echo " 🛠️ Updating package list..."
# sudo apt update
# echo ""

# Install Docker
echo " ✅ Installing Docker..."
sudo apt install docker.io -y
echo ""

# Start Docker service
echo " 🔄 Starting Docker service..."
sudo systemctl start docker
echo ""

# Enable Docker to start at boot
echo " 🔧 Enabling Docker to start at boot..."
sudo systemctl enable docker
echo ""

# Allow non-root users to run Docker commands
sudo chmod 777 /var/run/docker.sock

# Add user to the Docker group
sudo usermod -aG docker $USER && newgrp docker


echo " 🎉 Docker installation completed."
echo "Docker version:"
sudo docker --version



# ====================== Install Docker Compose ======================

# Install Git
sudo apt install git -y

# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# Install Docker Compose
# sudo apt install docker-compose -y

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# Check Docker Compose version
echo " 📦 Checking Docker Compose version..."
docker-compose version



# For running the script

# Make the Script Executable:    chmod +x docker_install.sh
# Run the Script                 ./docker_install.sh



# ================================== end of script ===============================