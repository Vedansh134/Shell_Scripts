#!/bin/bash

#########################################################################################
#=============================== install EKS script =====================================

# version : 1.0
# date : 24-09-2025
# Author : Vedansh kumar

# testing (change to set -xeou pipefail for testing)
set +xeou pipefail

# define variables
SUDO='sudo'

# take input from user
read -p "Enter the cluster name: (e.g. observability) : " CLUSTER_NAME
read -p "Enter the region (e.g. ap-south-1) : " REGION

# update the ubuntu package list
$SUDO apt-get update -y

# check AWS CLI is installed or not
if command -v aws >/dev/null 2>&1; then
    echo " ✅ AWS is already installed."
else
    echo " ❌ AWS is not installed. Firstly installed AWS"
fi

# check AWS CLI is configured or not
if aws sts get-caller-identity >/dev/null 2>&1; then
    echo " ✅ AWS is already configured."
else
    echo " ❌ AWS is not configured. Firstly configure AWS"
fi

# check kubectl is installed or not
if command -v kubectl >/dev/null 2>&1; then
    echo " ✅ kubectl is already installed."
else
    echo " ❌ kubectl is not installed. Proceeding with installation..."
    # Download the latest release of kubectl
    curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl

    # Make the kubectl binary executable
    chmod +x ./kubectl

    # Move the binary to a directory in your PATH
    $SUDO mv ./kubectl /usr/local/bin

    # Verify the installation
    kubectl version --short --client
fi

# check eksctl is installed or not
if command -v eksctl >/dev/null 2>&1; then
    echo " ✅ eksctl is already installed."
else
    echo " ❌ eksctl is not installed. Proceeding with installation..."
    # Download the latest release of eksctl
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

    # Move the binary to a directory in your PATH
    $SUDO mv /tmp/eksctl /usr/local/bin

    # Verify the installation
    eksctl version
fi

# EKS cluster function
eks_cluster_create() {
    echo " 🚀 EKS cluster creation started"
    echo ""
    read -p "Enter the number of zones (e.g. ap-south-1a,ap-south-1b give atleast 2): " ZONES

    echo " 🔧 Creating EKS cluster..."
    eksctl create cluster --name=$CLUSTER_NAME \
                          --region=$REGION \
                          --zones=$ZONES \
                          --without-nodegroup

    echo " ✅ EKS cluster '$CLUSTER_NAME' created successfully in region '$REGION'."
}

# Call the EKS cluster creation function
eks_cluster_create

# Associate IAM OIDC provider with the EKS cluster
echo " 🔧 Associating IAM OIDC provider with the EKS cluster..."
eksctl utils associate-iam-oidc-provider \
    --region $REGION \
    --cluster $CLUSTER_NAME \
    --approve

# Node group function
create_node_group() {
    echo "🚀 Node Group creation started"
    echo ""
    read -p "Enter the node type (e.g. t3.medium) : " NODE_TYPE
    read -p "Enter the min nodes (e.g. 2) : " MIN
    read -p "Enter the max nodes (e.g. 3) : " MAX

    eksctl create nodegroup --cluster=$CLUSTER_NAME \
                        --region=$REGION \
                        --name=observability-ng-private \
                        --node-type=$NODE_TYPE \
                        --nodes-min=$MIN \
                        --nodes-max=$MAX \
                        --node-volume-size=20 \
                        --managed \
                        --asg-access \
                        --external-dns-access \
                        --full-ecr-access \
                        --appmesh-access \
                        --alb-ingress-access \
                        --node-private-networking
}

# Call the Node Group creation function
create_node_group

# Update ./kube/config file
aws eks update-kubeconfig --name observability

#=============================== script end ==========================================