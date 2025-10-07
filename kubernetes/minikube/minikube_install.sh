#!/bin/bash

###########################################################################
# install minikube by minikube_install shell scripting
# version: 1.0
# author: Vedansh kumar
# date: 07-10-2025
# description: This shell-scripting install minikube
############################################################################

# change set -euo pipefail; add -x while debugging
set +euo pipefail

# define variables
SUDO="${SUDO:-sudo}"

# update ubuntu
echo " 🛠️ Updating Ubuntu packages..."
$SUDO apt-get update -y
echo ""

echo "🚀 Starting installation of Minikube..."

# Install dependencies
$SUDO apt install -y curl wget apt-transport-https

# -----------------------------------------------
# 1. Install Docker
# -----------------------------------------------

# function to install docker
install_docker(){
    echo "✅ Installing Docker..."
    if command -v docker >/dev/null 2>&1; then
        echo "Docker is alreaady installed"
    else
        echo "🚫 Docker is not installed, starting installation..."
        $SUDO apt install docker.io -y

        # Start Docker service
        $SUDO systemctl start docker

        # Enable Docker service
        $SUDO systemctl enable --now docker

        # Add your user to the docker group to run docker without sudo
        $SUDO usermod -aG docker $USER && newgrp docker
        echo ""
    fi
}

# -----------------------------------------------
# 2. Install Minikube
# -----------------------------------------------

# Install minikube
install_minikube(){
    echo "✅ Installing Minikube..."
    if command -v minikube >/dev/null 2>&1; then
        echo "Minikube is alreaady installed"
    else
        echo "🚫 Minikube is not installed, starting installation..."

        # download the Minikube binary using curl
        curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

        # make the binary executable and move it to your system's PATH
        chmod +x minikube
        $SUDO mv minikube /usr/local/bin/
        echo ""
    fi
}

# -----------------------------------------------
# 3. Install kubectl
# -----------------------------------------------

install_kubectl(){
    echo "✅ Installing kubectl..."
    if command -v kubectl >/dev/null 2>&1; then
        echo "kubectl is alreaady installed"
    else
        echo "🚫 kubectl is not installed, starting installation..."

        # download the latest release with the command
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

        # Make it executable and move it into your path
        chmod +x kubectl
        $SUDO mv kubectl /usr/local/bin/

    fi
}

# Call the functions
install_docker
install_minikube
install_kubectl

# --------------------------------------------------
# 4. confirm version
# --------------------------------------------------

echo ""
echo "🔍 Installed Versions:"
docker --version
minikube version
kubectl version --client --output=yaml
echo ""

# start minikube
echo "✅ Starting Minikube..."
minikube start --driver=docker --vm=true --force

# check cluster status
minikube status

# check nodes
kubectl get nodes

# =============================== end of script ===============================