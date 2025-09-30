#!/bin/bash

##############################################################################################
# ================================ Terraform installation script =============================

# for ubuntu/debian based systems

# version : 1.0
# author : Vedansh kumar
# date : 27/09/2025
# for testing (change to set -xeou pipefail for testing)
set +xeou pipefail

# variables
SUDO='sudo'

# Update ubuntu
echo " 🛠️ Updating Ubuntu packages..."
$SUDO apt update
echo ""

# terraform install function
install_terraform(){
    echo "Installing Terraform..."
    if command -v terraform >/dev/null 2>&1; then
        echo "✅ Terraform is already installed $(terraform --version | head -n1)"
    else
        echo "❌ Terraform is not installed, starting installation..."
        $SUDO apt-get install -y gnupg software-properties-common

        # Add HashiCorp GPG key
        wget -O- https://apt.releases.hashicorp.com/gpg | \
        gpg --dearmor | \
        $SUDO tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

        gpg --no-default-keyring \
        --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
        --fingerprint

        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        $SUDO apt update
        $SUDO apt install terraform -y
        echo " Terraform installation completed."
        echo ""
    fi
}

# call the install_terraform function
install_terraform

# check terraform version
echo " 📦 Checking Terraform version..."
terraform --version"
echo ""

# End of script