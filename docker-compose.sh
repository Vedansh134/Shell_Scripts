# ====================== Install Docker Compose ======================

# Install Git
sudo apt install git -y

# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# Install Docker Compose
sudo apt install docker-compose -y

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# Check Docker Compose version
echo " 📦 Checking Docker Compose version..."
docker-compose version



# For running the script

# Make the Script Executable:    chmod +x docker_install.sh
# Run the Script                 ./docker_install.sh



# ================================== end of script ===============================