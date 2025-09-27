#!/bin/bash

#############################################################################################
# =================================== Ansible installation script ===========================

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

# check python is installed or not
if command -v python >/dev/null 2>&1; then
    echo "✅ python is already installed $(python3 --version)"
else
    echo "❌ python is not installed, installing python3..."
    $SUDO apt install python3 -y
fi

# check pip is installed or not
if command -v pip >/dev/null 2>&1; then
    echo "✅ pip3 already installed: $(pip3 --version)"
else
    echo "❌ pip is not installed, installing pip..."
    $SUDO apt install python3-pip -y
fi

# ansible install function
install_ansible(){
    echo "  Installing Ansible..."
    if command -v ansible >/dev/null 2>&1; then
        echo "✅ Ansible is already installed $(ansible --version | head -n1)"
    else
        echo "❌ Ansible is not installed, starting installation..."
        $SUDO add-apt-repository ppa:ansible/ansible
        $SUDO apt update
        $SUDO apt install software-properties-common -y
        $SUDO add-apt-repository --yes --update ppa:ansible/ansible
        $SUDO apt install ansible -y
        echo " Ansible installation completed."
        echo ""
    fi
}

# call the install_ansible function
install_ansible

# check ansible version
echo " 📦 Checking Ansible version..."
ansible --version

# ======================================= end of script ======================================