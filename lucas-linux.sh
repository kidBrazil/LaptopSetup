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
BLACKMESA="[ Singularity Manager ] ||"

# Error Handling Function
error_render() {
  echo
  echo "${RED}[ ERROR ] || ${BLACKMESA}: $1${NC}"
  echo
  exit 1
}
# Render Titles
title_render() {
  clear


}

# Color Variables
ORANGE=`tput setaf 5`
GREEN=`tput setaf 2`
RED=`tput setaf 1`
YELLOW=`tput setaf 3`
NC=`tput sgr0`

# [ Output Art & Introduction ] ------------------------------------
clear
echo "${YELLOW}"
#Show ASCII Art if it's there.
if [ -f ./kryptonite.txt ]
then
  cat ./kryptonite.txt
fi
echo
sleep 2s
echo "======================================================================================"
echo "${NC}${RED}"
echo "Are You Ready For The [ SINGULARITY? ]"
echo "${NC}${YELLOW}"
echo "--------------------------------------------------------------------------------------"
read -p "${NC}${GREEN} [ YES JOIN THE SINGULARITY | NO REMAIN MORTAL ]" answer
clear
sleep 2s
clear

#[ UPDATE APT-GET]
echo "${NC}${YELLOW} [ Updating Data Repository - Prepare SUDO ]${NC}"

if sudo apt-get update
then
  clear
  echo "${GREEN}[ DATA REPOSITORY SUCCESSFULLY UPDATED ]${NC}"
else
  error_render "SUDO Failed to update Apt-Get...you are not ready for the singularity."
fi
# [ Check for GIT installation & Configuration ]
if git --version
then
    clear
    echo
    echo "${GREEN}Git is installed... Moving on to Git Configuration${NC}"
    sleep 5s
  else
    # Install Git on LInux
    sudo apt-get install git
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
  git config --global core.editor vim
  echo
  echo "${GREEN}Finished Configuring Git. Proceeding.${NC}"
fi

clear
echo
echo "${YELLOW}[ Installing XClip.... ]${NC}"
sleep 1s
# Install XClip
sudo apt-get install xclip
clear
echo "${YELLOW}[ Generating SSH Key.... ]${NC}"
# Generate SSH Key
ssh-keygen -t rsa -b 4096 -C $useremail
if eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
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
  read -p "${GREEN}Hit any key To Proceed?${NC}"
else
  error_render "SSH Keyagent not available"
fi


#[ Install OHMYZDSH ]
clear
echo "${YELLOW}[ INSTALLING OH-MY-ZSH ]${NC}"
echo
sudo apt-get install zsh
sudo apt-get install git-core
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
clear
echo
echo
echo "${GREEN}[ Successfully Installed ZSH and set as default ]"
echo
echo "For this to fully take effect you will have to ${RED}REBOOT.${GREEN}"
echo "Don't worry - The script will reboot at the end of the installation."
sleep 3s
read -p "${YELLOW}Ready To Continue with Configuring ZDSH?${NC}"
clear

#[ Install Vim & Vundle ]
clear
echo
echo "${YELLOW}[ INSTALLING BEST IDE ]${NC}"
echo
sudo apt-get install vim
echo
echo "${GREEN}[ Vim Successfully installed ] ${NC}"
echo
echo "${YELLOW}[ INSTALLING VUNDLE ]${NC}"
echo
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
clear

#[ Install Droid Sans Powerline Font ]
clear
echo
echo "${YELLOW}[ PREPARING FONT INSTALL BY CREATING DIRECTORIES ]${NC}"
mkdir zsh-my-powerline-fonts
cd zsh-my-powerline-fonts/
git clone https://github.com/powerline/fonts.git
./fonts/install.sh
cd ..
sudo rm -r zsh-my-powerline-fonts
clear
echo
echo "${GREEN}[ Powerline Patched Fonts Have Been Installed ...]"
echo
echo "You can change the fonts in your terminal preference to enable them${NC}"
sleep 5s

#[ Install TaskWarrior ]
clear
echo
echo "${YELLOW}[ INSTALLING TASKWARRIOR TASK MANAGER  ]${NC}"
echo
sleep 2s
sudo apt-get install task
clear
echo
echo "${GREEN}[ Successfully Installed TaskWarrior ]${NC}"
sleep 5s

#[ Install TREE ]
clear
echo
echo "${YELLOW}[ INSTALLING TREE FOLDER STRUCTURE VIEWER ]${NC}"
echo
sleep 2s
sudo apt-get install tree
clear
echo
echo "${GREEN}[ Successfully Installed Tree Folder Structure Viewer  ]${NC}"
sleep 5s

#[ Install Guake ]
clear
echo
echo "${YELLO}[ INSTALLING GUAKE TERMINAL ]${NC}"
sleep 2s
sudo apt-get install guake
clear
echo "${YELLO}[ SETTING UP GUAKE FOR STARTUP ]${NC}"
sleep 2s
cp /usr/share/applications/guake.desktop /etc/xdg/autostart/
clear
echo "${GREEN}[ Successfully Installed Guake Terminal ]${NC}"
sleep 3s

# Install Build Essentials and Libssl
sudo apt-get install build-essential libssl-dev
clear
echo
# Install LibPCRE3
sudo apt-get install libpcre3 libpcre3-dev libpcrecpp0v5
clear
echo
# install zlib
sudo apt-get install zlib1g-dev
clear
echo
# Install Process manager htop
sudo apt-get install htop
sudo apt-get install curl
sudo apt-get install npm

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

    # Linux Node Install Script
    clear
    echo
    echo "${YELLOW}[ Operating System Detected as: ${GREEN}Linux / GNU${NC}${YELLOW}]${NC}"
    sleep 2s
    # Prepare Install
    sudo apt-get update
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
    nvm install node 8.11.1
fi

#[ Install VUE Globally ]
clear
echo
echo "{$YELLOW}[ INSTALLING VUE.js Globally ]${NC}"
npm install -g vue
npm install -g vue-cli

#[ Install Libpng for pngquant ]
clear
echo
echo "${YELLOW}[ INSTALLING LIBPNG ]${NC}"
sudo apt-get install libpng-dev

#[ Install Libtool, automake, nams and autoconf ]
clear
echo
echo "${YELLOW} [ Fixing MOZJPEG ]${NC}"
sudo apt-get install libtool automake autoconf nasm

#[ Install CURA ]
clear
echo
echo "${YELLOW} [ Install CURA ]${NC}"
sudo add-apt-repository ppa:thopiekar/cura
sudo apt-get install cura

#[ Install Discord ]
clear
echo
echo "${YELLOW} [ Install Discord ]${NC}"
sudo snap install discord

#[ Install Postman ]
clear
echo
echo "${YELLOW} [ Install Discord ]${NC}"
sudo snap install postman

#[ Install Brave Browser ]
clear
echo
echo "${YELLOW} [ Install Brave Browser Beta ]${NC}"
curl -s https://brave-browser-apt-beta.s3.brave.com/brave-core-nightly.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-beta.gpg add -
source /etc/os-release
echo "deb [arch=amd64] https://brave-browser-apt-beta.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-beta-${UBUNTU_CODENAME}.list
sudo apt update
sudo apt install brave-browser-beta

#[ Install Steam ]
clear
echo
echo "${YELLOW} [ Install Steam ]${NC}"
sudo add-apt-repository multiverse
sudo apt-get update
sudo apt-get install steam

#[ Install Torrents ]
clear
echo
echo "${YELLOW} [ Install Steam ]${NC}"
sudo apt-get install transmission

#[ Install Spotify ]
clear
echo
echo "${YELLOW} [ Install Spotify ]${NC}"
snap install spotify

#[ Install Atom ]
clear
echo
echo "${YELLOW} [ Install Atom ]${NC}"
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get update
sudo apt-get install atom

#[ Install Docker ]
clear
echo
echo "${YELLOW} [ Install Docker ]${NC}"
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $(whoami)
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

base=https://github.com/docker/machine/releases/download/v0.16.0 && curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && sudo install /tmp/docker-machine /usr/local/bin/docker-machine

#[ Configuring VIM and ZSH ]

clear
echo
echo "${YELLOW}[ CONFIGURING VIM & ZSH ] ${NC}"
sudo apt install sed
# Fix Files
sed -i "s|user|$USER|g" dotfiles/.zshrc
# Copy Files
sudo cp ./dotfiles/.zshrc ~/.zshrc
sudo cp ./dotfiles/.vimrc ~/.vimrc
#[ Set ZSH as DEFAULT
echo "${YELLOW}[ SETTING ZSH AS DEFAULT ]${NC}"
chsh -s `which zsh`
#[ENDING]
clear
echo "${YELLOW}"
#Show ASCII Art if it's there.
sleep 2s
echo "======================================================================================"
echo
echo "[ SINGULARITY ACHIEVED ]"
echo
echo "List Of Installed Apps:"
echo
echo "- Git"
echo "- Xclip"
echo "- Zsh"
echo "- Vim"
echo "- Zsh Powerline Fonts"
echo "- Vundle (With Plugins)"
echo "- Tree"
echo "- TaskWarrior"
echo "- HTop"
echo "- Guake"
echo "- Curl"
echo "- Docker"
echo "- NPM"
echo "- NVM"
echo "- Node"
echo "- Vue"
echo "- Cura"
echo "- Spotify"
echo "- Transmission"
echo "- Discord"
echo "- Brave(Beta Stream)"
echo "- Steam"
echo "- Atom"
echo
echo "======================================================================================"
sleep 10s
read -p "${YELLOW}Ready To Reboot?${NC}"
sudo systemctl reboot -i
exit 1
