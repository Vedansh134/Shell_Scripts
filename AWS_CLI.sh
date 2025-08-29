#!/bin/bash

# ========================= AWS CLI Installation Script =========================

echo " 🚀 Installation of AWS CLI started"
echo ""

# Update ubuntu
echo " 🛠️ Updating Ubuntu packages..."
sudo apt update
echo ""


# Check if Python is installed
python3 --version &>/dev/null

if [[ $? -eq 0 ]]
then
    echo "Python3 is already installed"
else
    echo ""
    echo " 📦 Installing Python..."
    sudo apt install python3 -y
    python3 --version
    echo ""
fi


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

# Configure AWS CLI
echo " 📦 Configuring AWS CLI..."
sleep 10s
aws configure


# give accesstoken
# aws configure set aws_access_key_id YOUR_ACCESS_KEY_ID
# aws configure set aws_secret_access_key YOUR_SECRET_ACCESS_KEY
# aws configure set default.region YOUR_DEFAULT_REGION

# command structure
# aws <command> <subcommand> [options and parameters]
# example ----------   aws s3 ls

# ============================= end of script ===============================