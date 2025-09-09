#!/bin/bash

# ============================ Jenkins installation ============================

echo " 🚀 Installation of Jenkins started"
echo ""

# Update ubuntu
echo " 🛠️ Updating and upgrading Ubuntu packages..."
sudo apt update
sudo apt -y upgrade
echo ""

# Install Java (open JDK) for Jenkins
echo " 📦 Installing OpenJDK 21..."
sudo apt install fontconfig openjdk-21-jre
echo "Java Version:"
java -version
echo ""

# Add Jenkins repository and key
echo " 🔑 Adding Jenkins repository and key..."
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.gpg > /dev/null
echo ""

# Add Jenkins repository
echo " 📦 Adding Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.gpg] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
echo ""

# Install Jenkins
echo " ✅ Installing Jenkins..."
sudo apt install -y jenkins
echo ""

# Start Jenkins service
echo " 🔄 Starting Jenkins service..."
sudo systemctl start jenkins
echo ""

# Enable Jenkins to start at boot
echo " 🔧 Enabling Jenkins to start at boot..."
sudo systemctl enable jenkins
echo ""

# Check Jenkins status
echo " 🔍 Checking Jenkins status..."
sudo systemctl status jenkins
echo ""

# Allow non-root users to run Jenkins commands
sudo chmod 777 /var/run/jenkins.sock

# Add user to the Jenkins group
sudo usermod -aG jenkins $USER && newgrp jenkins

echo " 🎉 Jenkins installation completed."
echo "Jenkins version:"
sudo jenkins --version


# For running the script

# Make the Script Executable:    chmod +x jenkins_install.sh
# Run the Script                 ./jenkins_install.sh


# ================================== end of script ===============================