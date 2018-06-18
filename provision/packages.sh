#!/usr/bin/env bash

# Packages
NVM="nvm"
NODE="nodejs"
BUILD_ESSENTIAL="build-essential"
MONGO="mongodb-org"
GIT="git"
REDIS="redis-server"

# Prerequisites
GIT_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' $GIT | grep "install ok installed")
echo "Checking for $GIT: $GIT_INSTALLED"
if [ "" == "$GIT_INSTALLED" ]; then
  apt-get update
  apt-get install -y $GIT
fi

# MongoDB
export mongo_service=mongod
MONGO_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' $MONGO | grep "install ok installed")
echo "Checking for $MONGO: $MONGO_INSTALLED"
if [ "" == "$MONGO_INSTALLED" ]; then
# Currently there is currently no official release for Ubuntu 18.04 Bionic. 
# For this reason we will be using Xenial version instead.
  export codename=xenial
  export mongodb=3.6
  sudo dpkg --remove --force-remove-reinstreq mongo-tools
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
  # apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
  echo "deb http://repo.mongodb.org/apt/ubuntu ${codename}/mongodb-org/${mongodb} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org.list
  apt-get update -y
  sudo apt-get install -y "${MONGO}"
  # sudo cp /etc/mongod.conf.dpkg-new /etc/mongod.conf
  # echo "mongodb-org hold" | dpkg --set-selections && \
  # echo "mongodb-org-server hold" | dpkg --set-selections && \
  # echo "mongodb-org-shell hold" | dpkg --set-selections && \
  # echo "mongodb-org-mongos hold" | dpkg --set-selections && \
  # echo "mongodb-org-tools hold" | dpkg --set-selections && \
  sudo sed -i '/bind_ip = 127.0.0.1/,/bind_ip\ =\ 127\.0\.0\.1/s/^/#/' /etc/mongod.conf && \
  sudo service "${mongo_service}" restart
fi
# Start mongodb service if stopped
if (( $(ps -ef | grep -v grep | grep "${mongo_service}" | wc -l) > 0 ))
then
  echo "${mongo_service} is running!!!"
else
  /etc/init.d/"${mongo_service}" start
fi

# Nvm
echo "Checking for nvm installed?"
export HOME=/home/vagrant
if [ "$(command -v nvm)" == "" ]; then
  # Not installed
  echo "NVM not found. Installing..."
  curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
  echo "source ${HOME}/.nvm/nvm.sh" >> ~/.bashrc
  source /home/vagrant/.nvm/nvm.sh
  source ~/.bashrc
fi

# NVM_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' $NVM | grep "install ok installed")
# echo "Checking for $NVM: $NVM_INSTALLED"
# export HOME=/home/vagrant
# if [ "" == "$NVM_INSTALLED" ]; then
#   # Get latest version of node
#   curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
#   echo "source ${HOME}/.nvm/nvm.sh" >> ~/.bashrc
#   source /home/vagrant/.nvm/nvm.sh
#   source ~/.bashrc
#   # sudo export NVM_DIR="$HOME/.nvm"
# fi

# Node.js
NODE_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' $NODE | grep "install ok installed")
echo "Checking for $NODE: $NODE_INSTALLED"
chown -R vagrant:vagrant /home/vagrant/.nvm
if [ "" == "$NODE_INSTALLED" ]; then
  # Get node
  nvm install 10.4.0
  export HOME=/home/root
  apt-get install -y nodejs 
  npm install -g forever
  ln -s "$(which nodejs)" /usr/bin/node
  # Update npm
  npm install npm -g
  # Install yarn
  npm install -g yarn
fi

apt-get install redis-tools redis-server -y
# Required for node-gyp and leveldown. TODO: remove once this is no longer required
apt-get install python -y

BOWER_INSTALLED=$(npm list --depth 1 --parseable=true --global bower > /dev/null 2>&1)
echo "Checking for $BOWER: $BOWER_INSTALLED"
if [ "" == "$BOWER_INSTALLED" ]; then
  npm install -g bower
fi

GULP_INSTALLED=$(npm list --depth 1 --parseable=true --global gulp > /dev/null 2>&1)
echo "Checking for $GULP: $GULP_INSTALLED"
if [ "" == "$GULP_INSTALLED" ]; then
  npm install -g gulp
fi

NPM_INSTALLED=$(npm list --depth 1 --parseable=true --global npm > /dev/null 2>&1)
echo "Checking for $NPM: $NPM_INSTALLED"
if [ "" == "$NPM_INSTALLED" ]; then
  npm install -g npm
fi

YARN_INSTALLED=$(npm list --depth 1 --parseable=true --global yarn > /dev/null 2>&1)
echo "Checking for $YARN: $YARN_INSTALLED"
if [ "" == "$YARN_INSTALLED" ]; then
  npm install -g yarn
fi

echo "***********************************"
echo "Run npm install and then run app..."
echo "***********************************"
#cd app
#sudo npm install
#sudo forever start server.js


echo "*********************************"
echo "Success! Navigate to localhost..."
echo "*********************************"



