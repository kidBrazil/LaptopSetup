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
read -p "${NC}${GREEN} [ YES JOIN THE SINGULARITY | YES JOIN THE SINGULARITY ]" answer
clear
echo "[ GENERATING BIO IMPLANTS... ]"
sleep 1s
echo "[ PROCURING NETWORK CONNECTIONS... ]"
sleep 1s
echo "[ INITIATING SINGULARITY...]"
sleep 2s
clear

#[ UPDATE APT-GET]
echo "${NC}${YELLOW} [ Updating Data Repository - Prepare SUDO ]${NC}"

if sudo apt-get update
then
  clear
  echo "${GREEN}[ DATA REPOSITORY SUCCESSFULLY UPDATED ]${NC}"
else
  error_handle "SUDO Failed to update Apt-Get...you are not ready for the singularity."
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
    apt-get install git
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

clear
echo
echo "${YELLOW}[ Installing XClip.... ]${NC}"
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

#[ Install Vim & JANUS ]
clear
echo
echo "${YELLOW}[ INSTALLING BEST IDE ]${NC}"
echo
sudo apt-get install vim
echo
echo "${GREEN}[ Vim Successfully installed ] ${NC}"
echo
echo "${YELLOW}[ INSTALLING JANUS ] ${NC}"
curl -L https://bit.ly/janus-bootstrap | bash
sleep 1s
#[ Install Vundle Plugin Manager ]
echo
echo "${YELLOW}[ INSTALLING VUNDLE ]${NC}"
echo
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
clear

#[ Install OHMYZDSH ]
clear
echo "${YELLOW}[ INSTALLING OH-MY-ZSH ]${NC}"
echo
sudo apt-get install zsh
sudo apt-get install git-core
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
clear
echo
echo "${YELLOW}[ SETTING ZSH AS DEFAULT ]${NC}"
chsh -s `which zsh`
echo
echo "${GREEN}[ Successfully Installed ZSH and set as default ]"
echo
echo "For this to fully take effect you will have to ${RED}REBOOT.${GREEN}"
echo "Don't worry - The script will reboot at the end of the installation."
sleep 3s
read -p "${YELLOW}Ready To Continue with Configuring ZDSH?${NC}"
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


#[ Install Steam ]
clear
echo
echo "${YELLOW}[ INSTALLING STEAM ]${NC}"
sleep 2s
sudo apt-get install -y curl && \
  curl -L -s https://raw.github.com/gist/4713132/install-steam-repo.bash \
    | sudo bash
clear
echo "${GREEN}[ Sucessfully Installed Steam ]${NC}"
sleep 2s

#[ENDING]
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
echo
echo "[ SINGULARITY ACHIEVED ]"
echo
echo "List Of Installed Apps:"
echo
echo "- Git"
echo "- Xclip"
echo "- Vim"
echo "- Vim Janus Dist."
echo "- Vundle (With Plugins)"
echo "- OhMyZSH"
echo "- Tree"
echo "- TaskWarrior"
echo "- Guake"
echo
echo "======================================================================================"
sleep 5s
exit 1
