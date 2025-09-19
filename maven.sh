#/bin/bash
#
################################################################################
#================================= install maven ===============================
#
# version: 1.0
# Author: Vedansh kumar
# Description: This script installs Apache Maven on an Ubuntu system.
#
# testing (change to set -xeou pipefail for testing)
set +xeou pipefail

# define variables
SUDO='sudo'

# update ubuntu
echo "Updating ubuntu..."
$SUDO apt-get update

# function to install maven
install_maven(){
    echo "Installing Maven..."
    if command -v mvn >/dev/null 2>&1; then
        echo "Maven is already installed."
    else
        echo "Maven is not installed. Installing Maven..."
        $SUDO apt-get install maven -y
    fi
}

# call the install_maven function
install_maven

# start and enable maven
echo "enable and start maven"
$SUDO systemctl start maven
$SUDO systemctl enable maven

echo "check maven version"
mvn -version


# ============================== end of script ======================================
