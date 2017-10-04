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
echo "[ ${YELLOW}Black Mesa - Vue.js App${NC} ]"
echo
echo "${GREEN}Welcome Aboard Black Mesa! We are happy to have you as part"
echo "${GREEN}of our intrepid team. We are just getting your environment setup.${NC}"
echo
echo "__________________________________________________________________________________________"

sleep 2s
echo
echo "This Script will install and configure all the necessary Software & Dependencies to run the project."
echo
echo "${YELLOW}[ Including ]"
echo
echo "- Git"
echo "- Node & NPM"
echo "- Vue"
echo "- NPM Dependencies${NC}"
echo
echo
echo "For more information and useful documentation please refer "
echo "to the [${GREEN} ~/docs ${NC}] folder inside of this repository."
echo 
echo "It includes information on Linting, Testing and styleguides. "
echo
echo "------------------------------------------------------------------------------------------"

sleep 2s

echo
echo "${YELLOW}[ NOTICE! ]${NC} - This application depends on ${GREEN}Node.js${NC} and ${GREEN}Vue.js being installed globally."
echo
echo "${YELLOW}[ NOTICE! ]${NC} - This Installation Script will check to make sure Node.js install and install it for you if necessary."
echo
echo "${RED}[ SUDO! ]${NC} - This application requires ${YELLOW}SUDO priviledges${NC} to install ${GREEN}Node${NC}."

sleep 1s
echo
# TODO Modify Prompt
# Ask User for permission
echo "${YELLOW}--------------------------------------------${NC}"
echo "${YELLOW}--------------------------------------------${NC}"
read -p "${YELLOW}|   Continue with installation?   ${NC}|${NC}  " answer

# [ Black Mesa ] Setup Script RUN
clear
echo "${GREEN}Initiating Install...${NC}"
echo
sleep 2s

# [ BASE SYSTEM CHECKS ]
# Check and install system dependencies based on OS

# Check for XCode on OSX platforms
if [ "$(uname)" == "Darwin" ]
then
  if gcc
  then
    clear
  else
    clear
    echo
    echo "${RED}Missing xCode developer tools...${NC}"
    echo "${YELLOW}Please Install xCode before trying again${NC}"
    error_handle "Apple xCode Developer Tools are not installed."
  fi
else
  echo "Not Darwin"
  sleep 1s
  clear
fi

# Check for GIT installation & Configuration
if git --version
then
    clear
    echo
    echo "${GREEN}Git is installed... Moving on to Git Configuration${NC}"
    sleep 5s
  else
    # [ INSTALL GIT BASED ON OS ]
    if [ "$(uname)" == "Darwin" ]
    then
      # Mac / OSX 
      # Check for BREW
      if brew help
      then
        echo "${GREEN}Brew is installed... proceeding with Node."
        sleep 2s
      else
        echo
        echo "${GREEN}Installing Homebrew Package Manager for OSX.${NC}"
        sleep 2s
        # Install brew
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      fi
      #Install Git
      clear
      echo
      echo "${GREEN}Installing Git...${NC}"
      sleep 2s
      brew install git
    
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
    then
      # Install Git on LInux
      apt-get install git

    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]
    then
      # Check for Chocolatey package manager
      if choco
      then
        echo
        echo "${GREEN} Chocolatey is installed... proceeding with Node."
        sleep 2s
      else
        # Install chocolatey via Command Prompt
        iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
      fi
      # Install Git on Windows
      choco install git.install
    elif *
    then
      error_handle "Could Not Find Your OS. Please Install Git Manually And Try Again."
    fi
fi

# [ CONFIGURE GIT ]
if git config --global user.name
then
  # Git Config Already done.
  clear
  echo
  echo "${GREEN}Git global parameters already configured. Proceeding.${NC}"
  sleep 5s
else
  echo "${YELLOW}Configuring Git Base Parameters.${NC}"
  echo
  sleep 2s
  # Configure --global user.name
  read -p "${GREEN}Please enter your --global user.name...${NC}  " username
  git config --global user.name $username
  sleep 2s
  # Configure --global user.email
  echo
  read -p "${GREEN}Please enter your --global user.email...${NC}  " useremail
  git config --global user.email $useremail
  echo
  echo "${GREEN}Finished Configuring Git. Proceeding.${NC}"
fi

sleep 2s
clear
echo 
echo "${GREEN}Setting Up SSH Keys${NC}"
echo
sleep 3s

# [ GET RSA KEYS SETUP ]
if ls -al ~/.ssh/id_rsa.pub
then
  # ID Setup Moving On
  clear
  echo
  echo "${GREEN}Public Key Already Generated... Proceeding.${NC}"
  sleep 2s
else
  # Generate ID
  clear
  echo
  echo "${GREEN}Generating RSA Key Pairs..."
  echo
  sleep 2s
  # Generate SSH Key
  read -p "${YELLOW}Please Enter the Same Email Used For user.email...${NC}" useremailrsa
  ssh-keygen -t rsa -b 4096 $useremailrsa
  sleep 1s
  # Add to SSH Agent
  echo
  echo "${GREEN}Adding Key to SSH Agent...${NC}"
  sleep 2s
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
  sleep 2s
fi

clear
echo
echo "${GREEN}Adding RSA Keys to Github Account...${NC}"

# Use Key on Mac.
if [ "$(uname)" == "Darwin" ]
then
  #Copy key to Clipboard
  pbcopy < ~/.ssh/id_rsa.pub
  clear
  cat ~/.ssh/id_rsa.pub
  echo
  echo "${YELLO}Your Public SSH Key is Now Loaded In Your ${GREEN}CLIPBOARD (ctrl/cmd+v)${NC}"
  echo
  echo "${YELLOW} Please visit https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/"
  echo "For instructions on how to add it to your GitHub Account."
  echo
  sleep 2s
  read -p "${GREEN}Ready To Proceed?${NC}"

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then
  clear
  echo
  echo "${GREEN}Installing XClip....${NC}"
  sleep 1s
  # Install XClip
  sudo apt-get install xclip
  # Copy RSA to Clipboard
  echo 
  echo "${GREEN}Copying RSA Key To Clipboard...${NC}"
  sleep 2s
  xclip -sel clip < ~/.ssh/id_rsa.pub
  cat ~/.ssh/id_rsa.pub
  echo
  echo "${YELLO}Your Public SSH Key is Now Loaded In Your ${GREEN}CLIPBOARD (ctrl/cmd+v)${NC}"
  echo
  echo "${YELLOW} Please visit https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/"
  echo "For instructions on how to add it to your GitHub Account."
  sleep 2s
  echo
  read -p "${GREEN}Ready To Proceed?${NC}"

elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]
then
  # Copy RSA Key To Clipboard
  clear
  echo
  echo "${GREEN}Copying RSA Key to Clipboard..${NC}"
  sleep 2s
  clip < ~/.ssh/id_rsa.pub
  echo
  echo "${YELLO}Your Public SSH Key is Now Loaded In Your ${GREEN}CLIPBOARD (ctrl/cmd+v)${NC}"
  echo
  echo "${YELLOW} Please visit https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/"
  echo "For instructions on how to add it to your GitHub Account."
  sleep 2s
  echo
  read -p "${GREEN}Ready To Proceed?${NC}"
elif *
then
  error_handle "Your OS Was Not Found... Please Setup SSH manually."
fi

# [[ NODE JS ]].
if node -v
  then
    echo
    echo "${GREEN}Node is already installed. Proceeding with Dependencies...${NC}"
    sleep 5s
  else
    clear
    echo
    echo "${RED}Node installation is missing.${NC}"
    echo
    echo "${GREEN}Preparing to Install Node..."
    sleep 3s
    
    #[ OS BASED NODE INSTALLATION ]
    if [ "$(uname)" == "Darwin" ]
    then
      # OSX Install Script
      clear
      echo 
      echo "${YELLOW}[ Operating System Detected as: ${GREEN}Darwin / OSX${NC} ${YELLOW}]${NC}"
      echo
      sleep 2s
      # Install Node
      echo
      echo "${GREEN}Installing Node via Bew. Cheers!${NC}"
      sleep 2s
      brew install node

    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
    then
      # Linux Node Install Script
      clear
      echo
      echo "${YELLOW}[ Operating System Detected as: ${GREEN}Linux / GNU${NC}${YELLOW}]${NC}"
      sleep 2s
      # Prepare Install
      curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash
      # Install Node
      sudo apt-get install -y nodejs
    
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]
    then
      # Windows
      # Install Node VIa Chocolatey
      cinst nodejs.install
    elif *
    then
      error_handle "Could Not Find Your OS. Please Install Node Manually And Try Again."
   fi
fi
# NODE INSTALL FINISH.

# Fetch latest master branch
echo "${GREEN}Fetching latest codebase from Master...${NC}"
if git fetch && git checkout master && git pull origin master
  then
    sleep 2s
else
  error_handle "Please clear your Git workspace by commiting or stashings your changes and try again."
fi
echo
echo
echo "${GREEN}Installing Vue.js Globally...${NC}"
echo
echo
sleep 2s

# Check for existing Vue Install
if vue
then
  echo "${GREEN}Vue.JS is already installed!${NC}"
  sleep 5s
else
  if npm install -g vue
  then
    sleep 1s
    clear
    echo
    echo
    echo "${GREEN}Vue.JS Installed successfully!${NC}"
  else
    error_handle "There was a problem installing Vue.js - Visit http://vuejs.org for Manual Installation steps"
  fi
fi

# Install NPM dependencies
sleep 1s
clear
echo
echo "${GREEN}Installing Node dependencies...${NC}"
echo
echo
sleep 2s
if cd vue-app-base/
  then
    npm install
else
  error_handle "Seems there was a problem here. Contact an Admin."
fi
echo

# Run Test Server
clear
echo 
echo "${GREEN}SUCCESS! All dependencies installed...${NC}"
echo
echo "${GREEN}[ Welcome Aboard The ${ORANGE}Black Mesa${GREEN} ]${NC}"
echo
echo "${GREEN}------------------------------------------------------------------------------------------${NC}"
echo
echo "Please refer to the ${GREEN}[ ~/docs ]${NC} folder or the GitHub Wiki for guides on"
echo
echo "${YELLOW}- Dependencies"
echo "${YELLOW}- Naming Convention"
echo "${YELLOW}- Code Styleguide"
echo "${YELLOW}- Linting"
echo "${YELLOW}- Best Practices"
echo "${YELLOW}- Code Recepies"
echo "${YELLOW}- Routes [vue-router]"
echo "${YELLOW}- VueX [State Management]"
echo "${YELLOW}- Vue Resource [Ajax Wrapper]"
echo "${YELLOW}- Firebase [OODB]"
echo "${YELLOW}- Templating Structure"
echo "${YELLOW}- Responsive Breakpoints"
echo "${YELLOW}- SCSS Structure"
echo "${YELLOW}- SCSS Styleguide"
echo "${YELLOW}- And More...${NC}"
sleep 3s
echo
echo "${YELLOW}Booting Up Test Server on [ ${GREEN}localhost:8080${NC} ]"
echo
sleep 1s
npm run dev;
