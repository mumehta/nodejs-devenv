#!/usr/bin/env bash
locale-gen en_US.UTF-8

# Setting timezone
sudo timedatectl set-timezone Australia/Perth
echo "***********************"
echo "Updating apt sources..."
echo "***********************"
sudo apt-get -qq update
sudo apt-get install -y build-essential curl git libssl-dev libc-ares2 libhttp-parser2.7.1 libuv1 man 

# Update apt-get
# apt-get update -y

# Update Ubuntu
apt-get -y upgrade
apt-get -y dist-upgrade