#!/bin/bash
#
#############################################################################
# =============================== Install mysql =============================
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

# function to install mysql
mysql_install(){
    echo "Installing Mysql"
    if command -v >/dev/null 2>&1; then
        echo "Mysql is already installed"
    else
        echo "Mysql is not installed, Start Installing ..."
        $SUDO apt install mysql-server -y
    fi
}

# call the mysql function
mysql_install

# start and enable mysql
echo "enable and start maven"
sudo systemctl status mysql.service
sudo systemctl start mysql.service

echo "check mysql version"
mysql -version

# ============================== end of script ======================================
