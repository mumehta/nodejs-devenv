#!/usr/bin/env bash
echo "*******************************" 
echo "Provisioning virtual machine..."
echo "*******************************" 

/vagrant/provision/ubuntu.sh

/vagrant/provision/packages.sh

/vagrant/provision/phantom.js

/vagrant/provision/java.sh

/vagrant/provision/docker.sh

# Add hosts
echo "127.0.0.1 nodejs" >> /etc/hosts

# Default to app dir
echo "cd /vagrant/app" >> /home/ubuntu/.bashrc
