#!/usr/bin/env bash
clear
# [ Black Mesa - Vue.js Dependencies ]
# ------------------------------------------------------------------
# Lucas Moreira - l.moreira@live.ca
# ------------------------------------------------------------------
#
# Setup Bash Script for installing Node dependencies and running dev server
# with support for Windows | Mac | Linux architectures.

# Program Variables
BLACKMESA="[ Black Mesa ] | Setup Script"

# Error Handling Function
error_handle() {
  echo
  echo "${RED}[ ERROR ] || ${BLACKMESA}: $1${NC}"
  echo
  exit 1
}

# Color Variables
ORANGE=`tput setaf 5`
GREEN=`tput setaf 2`
RED=`tput setaf 1`
YELLOW=`tput setaf 3`
NC=`tput sgr0`

# Intro / Continue
echo "__________________________________________________________________________________________"
echo
echo "[ ${YELLOW}Moreira Development - LEMP Local Dev Stack${NC} ]"
echo
echo "__________________________________________________________________________________________"

sleep 2s
echo
echo "This script will setup Nginx as a local PHP server on port 80 for localhost"
echo
echo "------------------------------------------------------------------------------------------"

sleep 2s

echo "${RED}[ SUDO! ]${NC} - This application requires ${YELLOW}SUDO priviledges${NC} to install ${GREEN}Node${NC}."

sleep 1s
echo
read -p "${YELLOW}|   Continue with installation?   ${NC}|${NC}  " answer

# [ Black Mesa ] Setup Script RUN
clear
echo "${GREEN}Initiating Install...${NC}"
echo
sleep 2s

# [ BASE SYSTEM CHECKS ]
# Check and install system dependencies based on OS

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then
  echo "${GREEN} Installing Nginx... ${NC}"
  sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove
  sudo apt-get install nginx
  echo "${GREEN} Installing PHP Support.. ${NC}"
  sudo apt-get install mysql-server mysql-client
  echo "${GREEN} Installing PHP-FPM.. ${NC}"
  sudo apt-get install php-fpm php-mysql
fi


if [ "$(uname)" == "Darwin" ]
then
  echo "${GREEN} Installing Nginx... ${NC}"
  brew upgrade && brew update && brew install nginx
  echo "${GREEN} Installing PHP Support.. ${NC}"
  brew install mysql-server mysql-client
  echo "${GREEN} Installing PHP-FPM.. ${NC}"
  brew install php-fpm php-mysql
fi


echo "${GREEN} Securint PHP Installation... ${NC}"
sudo mysql_secure_installation

echo "${GREEN} Adding Nginx Configuration ${NC}"
sudo cp lemp-local.conf /etc/nginx/sites-available/default
sudo cp dev.mdev-theme /etc/nginx/sites-available/dev.mdev-theme
sudo cp index.html /var/www/index.html

sudo ln -s /etc/nginx/sites-available/dev.mdev-theme /etc/nginx/sites-enabled/dev.mdev-theme

sudo echo "127.0.0.1 dev.mdev-theme" >> /etc/hosts

echo "${GREEN} Restarting Nginx ${NC}"
echo

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then
  sudo systemctl reload nginx.service
fi

if [ "$(uname)" == "Darwin" ]
then
  sudo nginx -s stop && sudo nginx
fi

echo "${GREEN} Nginx is available on localhost ${NC}"
exit 1
