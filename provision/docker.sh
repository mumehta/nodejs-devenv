#!/usr/bin/env bash


sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Install recommended extra packages
# apt-get install -y \
#     linux-image-extra-$(uname -r) \
#     linux-image-extra-virtual

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# Set up the stable repo
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the packages
sudo apt-get update -y

# Install docker-ce
sudo apt-get install -y docker-ce
curl -fsSL test.docker.com | sudo -E bash -

# Access docker w/o sudo
sudo usermod -aG docker vagrant