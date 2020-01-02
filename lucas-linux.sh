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
BLACKMESA="[ BLACK MESA ] ||"

# Error Handling Function
error_render() {
  echo
  echo "${RED}[ ERROR ] || ${BLACKMESA}: $1 ${NC}"
  echo
  exit 1
}
# Render Titles
title_render() {
  clear
  echo
  echo "${YELLOW}[ INSTALL PACKAGE ] || $1 ?${NC}"
  echo
  sleep 2s
}
# Render Installed
installed_render() {
  clear
  echo
  echo "${GREEN}[ $1 IS ALREADY INSTALLED || MOVING TO NEXT PACKAGE ]${NC}"
  echo
  sleep 2s
}
# Render Configured
cfged_render() {
  clear
  echo
  echo "${GREEN}[ $1 IS ALREADY CONFIGURED ]${NC}"
  echo
  sleep 2s
}
# Render Configuring
cfg_render() {
  clear
  echo
  echo "${YELLOW}[ CONFIGURING ] || $1 ${NC}"
  echo
  sleep 2s
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

#[ UPDATE APT-GET] ------------------------------------------------------------//
echo "${NC}${YELLOW} [ Updating Data Repository - Prepare SUDO Powers ]${NC}"
if sudo apt-get update
then
  clear
  echo "${GREEN}[ DATA REPOSITORY SUCCESSFULLY UPDATED ]${NC}"
else
  error_render "Failed to update Apt-Get."
fi

# [ Check for GIT installation & Configuration ] ------------------------------//
if git --version
then
  installed_render "GIT Bash"
  else
    # Install Git on LInux
    title_render "Git Bash"
    sudo apt-get install git
fi
# [ CONFIGURE GIT ]
if git config --global user.name
then
  # Git Config Already done.
  cfged_render "Git Global Settings"
else
  cfg_render "Git Global Settings"
  # Configure --global user.name
  read -p "${GREEN}Please enter your global user.name...${NC}  " username
  git config --global user.name $username
  sleep 2s
  # Configure --global user.email
  echo
  read -p "${GREEN}Please enter your global user.email...${NC}  " useremail
  git config --global user.email $useremail
  git config --global core.editor vim
  cfged_render "Git Global Settings"
fi

# [ SSH Key Generation ] ------------------------------------------------------//
title_render "XClip"
# Install XClip
sudo apt-get install xclip
installed_render "XClip"
cfg_render "SSH Keys"
# Generate SSH Key
ssh-keygen -t rsa -b 4096 -C $useremail
# Check for SSH Agent
if eval "$(ssh-agent -s)"
then
  echo "${YELLOW}Adding SSH Key to Keychain...${NC}"
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

# [ Install OHMYZDSH ] --------------------------------------------------------//
title_render "OhMy ZDSH"
sudo apt-get install zsh
sudo apt-get install git-core
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
clear
installed_render "OhM ZDSH"
sleep 1s
echo "For this to fully take effect you will have to ${RED}REBOOT.${GREEN}"
echo "Don't worry - The script will reboot at the end of the installation."
sleep 3s
read -p "${YELLOW}Ready To Continue with Configuring ZDSH?${NC}"
clear

#[ Install Vim & Vundle ] -----------------------------------------------------//
title_render "VIM"
sudo apt-get install vim
installed_render "VIM"
title_render "Vundle Plugins"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
installed_render "Vundle Plugins"
sleep 3s
#[ Install Droid Sans Powerline Font ]
clear
echo
echo "${YELLOW}[ Installing Powerline Fonts ]${NC}"
mkdir zsh-my-powerline-fonts
cd zsh-my-powerline-fonts/
git clone https://github.com/powerline/fonts.git
./fonts/install.sh
cd ..
sudo rm -r zsh-my-powerline-fonts
installed_render "Powerline Fonts"
echo
echo "${YELLOW}You can change the fonts in your terminal preference to enable them${NC}"
sleep 3s

#[ Install TaskWarrior ] ------------------------------------------------------//
title_render "Taskwarrior"
sudo apt-get install task
installed_render "Taskwarrior"
sleep 3s

#[ Install TREE ] -------------------------------------------------------------//
title_render "Tree Folder Viewer"
sudo apt-get install tree
installed_render "Tree Folder Viewer"
sleep 3s

#[ Install Guake ] ------------------------------------------------------------//
title_render "GUAKE"
sudo apt-get install guake
installed_render "GUAKE"
sleep 3s

#[ Install Mooltipass ] -------------------------------------------------------//
title_render "MOOLTIPASS"
sudo add-apt-repository ppa:mooltipass/moolticute
sudo apt-get update
sudo apt-get install moolticute
installed_render "MOOLTIPASS"
sleep 3s

#[ Install Libraries ] --------------------------------------------------------//
# Install Build Essentials and Libssl
clear
echo "${YELLOW}[ INSTALLING DEV LIBRARIES ]${NC}"
sudo apt-get install build-essential libssl-dev
clear
echo
# [ Install LibPCRE3 ]
sudo apt-get install libpcre3 libpcre3-dev libpcrecpp0v5
clear
# [install zlib]
sudo apt-get install zlib1g-dev
clear
#[ Install Libpng for pngquant ]
sudo apt-get install libpng-dev
clear
#[ Install Libtool, automake, nams and autoconf ]
sudo apt-get install libtool automake autoconf nasm
installed_render "DEV LIBRARIES"
sleep 3s

#[ HTOP / CURL / NPM] ---------------------------------------------------------//
title_render "HTOP Process Manager"
sudo apt-get install htop
installed_render "HTOP Process Manager"
sleep 3s

title_render "CURL DOWNLOADER"
sudo apt-get install curl
installed_render "CURL DOWNLOADER"
sleep 3s

title_render "NODE PACKAGE MANAGER"
sudo apt-get install npm
installed_render "NODE PACKAGE MANAGER"
sleep 3s

title_render "WALLCH CHANGER"
sudo apt-get install wallch
installed_render "WALLCH CHANGER"
sleep 3s

#[ NODE ] ---------------------------------------------------------------------//
if node -v
  then
    installed_render "NODE JS"
    sleep 3s
  else
    title_render "NODE JS"
    sudo apt-get update
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
    nvm install node --lts
    nvm use --lts
    installed_render "NODE JS"
    sleep 3s
fi

#[ Install VUE Globally ] -----------------------------------------------------//
title_render "VUE JS"
npm install -g vue
npm install -g vue-cli
installed_render "VUE JS"
sleep 3s

#[ Install CURA ] -------------------------------------------------------------//
title_render "CURA SLICER"
sudo add-apt-repository ppa:thopiekar/cura
sudo apt-get install cura
installed_render "CURA SLICER"
sleep 3s

#[ Install Discord ] ----------------------------------------------------------//
title_render "DISCORD"
sudo snap install discord
installed_render "DISCORD"
sleep 3s

#[ Install Slack ] ------------------------------------------------------------//
title_render "SLACK"
sudo apt-get install slack
installed_render "SLACK"
sleep 3s

#[ Install Postman ] ----------------------------------------------------------//
title_render "POSTMAN"
sudo snap install postman
installed_render "POSTMAN"
sleep 3s

#[ Install Brave Browser ] ----------------------------------------------------//
title_render "BRAVE BETA"
curl -s https://brave-browser-apt-beta.s3.brave.com/brave-core-nightly.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-beta.gpg add -
source /etc/os-release
echo "deb [arch=amd64] https://brave-browser-apt-beta.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-beta-${UBUNTU_CODENAME}.list
sudo apt update
sudo apt install brave-browser-beta
installed_render "BRAVE BETA"
sleep 3s

#[ Install Steam ] ------------------------------------------------------------//
title_render "STEAM GAMES"
sudo add-apt-repository multiverse
sudo apt-get update
sudo apt-get install steam
installed_render "STEAM GAMES"
sleep 3s

#[ Install Torrents ] ---------------------------------------------------------//
title_render "TRANSMISSION TORRENTS"
sudo apt-get install transmission
installed_render "TRANSMISSION TORRENTS"
sleep 3s

#[ Install Spotify ] ----------------------------------------------------------//
title_render "SPOTIFY"
snap install spotify
installed_render "SPOTIFY"
sleep 3s

#[ Install Atom ] -------------------------------------------------------------//
title_render "ATOM EDITOR"
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get update
sudo apt-get install atom
installed_render "ATOM EDITOR"
sleep 3s

#[ Install Docker ] -----------------------------------------------------------//
title_render "DOCKER"
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
installed_render "DOCKER"
sleep 3s

#[ Install NVIDIA Drivers ] ---------------------------------------------------//
title_render "NVIDIA Drivers"
sudo apt-get purge nvidia*
sudo add-apt-repository ppa:graphics-drivers
sudo apt-get update
sudo apt-get install nvidia-375
installed_render "NVIDIA Drivers"
sleep 3s

#[ Configuring VIM and ZSH ] --------------------------------------------------//
clear
echo
echo "${YELLOW}[ CONFIGURING VIM & ZSH ] ${NC}"
sudo apt install sed
clear
# Fix Files
sed -i "s|user|$USER|g" dotfiles/.zshrc
# Copy Files
sudo cp ./dotfiles/.zshrc ~/.zshrc
sudo cp ./dotfiles/.vimrc ~/.vimrc
cfged_render "VIM and ZSH"
sleep 3s

#[ENDING]
clear
echo "${GREEN}"
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
echo "- Mooltipass"
echo "- SLACK"
echo "- NVIDIA Drivers"
echo
echo "======================================================================================"
sleep 10s
read -p "${YELLOW}Ready To Reboot?${NC}"
#[ Set ZSH as DEFAULT ] -------------------------------------------------------//
echo "${YELLOW}[ SETTING ZSH AS DEFAULT ]${NC}"
chsh -s `which zsh`
exit 1 && sudo systemctl reboot -i
