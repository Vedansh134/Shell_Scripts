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
