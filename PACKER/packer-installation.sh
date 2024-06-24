#!/bin/bash

set -e  # Exit script immediately if any command returns a non-zero status

# Update package lists
sudo apt-get update

# Install wget and unzip if not already installed
sudo apt-get install -y wget unzip

# Download Packer
wget https://releases.hashicorp.com/packer/1.7.8/packer_1.7.8_linux_amd64.zip

# Unzip Packer
unzip packer_1.7.8_linux_amd64.zip

# Move Packer executable to /usr/local/bin/
sudo mv packer /usr/local/bin/

# Clean up downloaded zip file (optional)
rm packer_1.7.8_linux_amd64.zip
