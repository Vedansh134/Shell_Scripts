#!/bin/bash

# ========================= install helm script ==============================
#
# version : 1.0
# date    : 2024-06-10
# author  : Vedansh kumar

# testing (change to set -xeou pipefail for testing)
set +xeou pipefail

# define variables
SUDO='sudo'

# update the ubuntu package list
$SUDO apt-get update -y

# helm install function
install_helm() {
    echo " 🚀 Installation of Helm started"
    echo ""
    if command -v helm >/dev/null 2>&1; then
        echo " ✅ Helm is already installed."
    else
        echo " ❌ Helm is not installed. Proceeding with installation..."
        # Download the Helm installation script
        curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
        # Make the script executable
        chmod 700 get_helm.sh
        # Run the installation script
        ./get_helm.sh
    fi
}

# Call the install function
install_helm

# Check Helm version
echo " 📦 Checking Helm version..."
helm version

# ============================== script end ==============================