#!/bin/bash

# ========================= AWS CLI Installation Script =========================

echo " 🚀 Installation of AWS CLI started"
echo ""

# Update ubuntu
echo " 🛠️ Updating Ubuntu packages..."
sudo apt update
echo ""

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Install unzip
sudo apt install unzip -y

# unzip the installer
unzip awscliv2.zip

# Install AWS CLI
sudo ./aws/install

# Verify the installation
echo " 📦 Verifying the installation..."
aws --version

# ============================= end of script ===============================