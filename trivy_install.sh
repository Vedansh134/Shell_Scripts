#!/bin/bash

# ========================= install trivy script ==============================

# testing (change to set -xeou pipefail for testing)
set +xeou pipefail

# define variables
SUDO='sudo'

echo " 🚀 Installation of Trivy started"
echo ""

# trivy install function
install_trivy() {
    echo " 🔧 Installing Trivy..."
    if command -v trivy >/dev/null 2>&1; then
        echo " ✅ Trivy is already installed."
    else
        echo " ❌ Trivy is not installed. Proceeding with installation..."
        # Install required packages
        $SUDO apt-get install wget apt-transport-https gnupg lsb-release -y
        # Add Trivy GPG key
        echo " 🔑 Adding Trivy GPG key..."
        wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | $SUDO apt-key add -
        echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | $SUDO tee -a /etc/apt/sources.list.d/trivy.list
    fi
}

# Call the install function
install_trivy

# Update package list and install Trivy
echo " 🛠️ Updating package list and installing Trivy..."
$SUDO apt-get update -y
$SUDO apt-get install trivy -y

# Check Trivy version
echo " 📦 Checking Trivy version..."
trivy --version

# ============================== script end ============================
