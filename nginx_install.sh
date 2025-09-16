#!/bin/bash
#
##################################################################################
# ===================== install and configure nginx server ===================== #
#
# define variables
SUDO='sudo'
#
# testing (set - for debugging)
set +xeuo pipefail

# update ubuntu
echo " 🛠️ Updating Ubuntu packages..."
$SUDO apt update
echo ""

# check if nginx is installed
nginx -v &>/dev/null

if [[ $? -eq 0 ]]; then
    echo "Nginx is already installed"
    exit 0
else
    echo "Nginx is not installed"
    echo " 📦 Installing Nginx web server..."
    $SUDO apt install nginx -y
    echo ""
fi

# start and enable nginx service
echo " 🚀 Starting and enabling Nginx service..."
$SUDO systemctl start nginx
$SUDO systemctl enable nginx
echo ""

# check status of nginx
echo "Check the status of Nginx service"
$SUDO systemctl is-active nginx.service && echo "Nginx is active" || echo "Nginx is not active"
echo ""

# =================================== End of script =====================================
