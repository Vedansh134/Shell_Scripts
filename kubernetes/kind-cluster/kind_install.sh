#!/bin/bash

################################################################################
# install kind by kind_install.sh scripting
# version: 1.0
# author: Vedansh kumar
# date: 05-10-205
# description: This shell-scripting install kind-cluster
################################################################################

# change set -euo pipefail; add -x while debugging
set +euo pipefail

# define variables
SUDO="sudo"
ARCH="$(uname -m)"

# update ubuntu
echo " 🛠️ Updating Ubuntu packages..."
$SUDO apt-get update -y
echo ""

echo "🚀 Starting installation of Kind, and kubectl..."

# ------------------------------------------------
# 1. Install Kind (based on architecture)
# ------------------------------------------------

if command -v kind >/dev/null 2>&1; then
    echo "✅ Kubectl is already installed: $(kubectl --version 2>&1)"
    echo ""
else
    echo "📥 Installing kind for architecture: $ARCH"
    case "$ARCH" in
        x86_64|amd64)
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.30.0/kind-linux-amd64
        ;;

        aarch64|arm64)
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.30.0/kind-linux-arm64
        ;;

        *)
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
        ;;
    esac

    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    echo "✅ Kind installed successfully."
fi


# ------------------------------------------------
# 2. Install kubectl (latest stable)
# ------------------------------------------------

if command -v kubectl >/dev/bin 2>&1; then
    echo "✅ Kubectl is already installed: $(kubectl --version 2>&1)"
    echo ""
else
    echo "📥 Installing kubectl for architecture: $ARCH"
    case $ARCH in
        x86_64|amd64)
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        ;;

        aarch64|arm64)
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
        ;;

        *)
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
        ;;
    esac

    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm -f kubectl
    echo "✅ kubectl installed successfully."
fi

# --------------------------------------------------
# 3. confirm version
# --------------------------------------------------

echo ""
echo "🔍 Installed Versions:"
kind --version
kubectl version --client --output=yaml
echo ""

echo "🎉 Kind and kubectl installation completed successfully!"

# ===================================== end of script =====================================