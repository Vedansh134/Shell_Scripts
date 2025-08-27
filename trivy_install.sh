#!/bin/bash

# ========================= install trivy script ==============================

# Install required packages
echo
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

# Add Trivy GPG key
echo " 🔑 Adding Trivy GPG key..."
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list

# Update package list and install Trivy
echo " 🛠️ Updating package list and installing Trivy..."
sudo apt-get update -y
sudo apt-get install trivy -y

# Check Trivy version
echo " 📦 Checking Trivy version..."
trivy --version
