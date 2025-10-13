#!/usr/bin/env bash

# Install dependencies
LIKE_DEBIAN=(debian ubuntu linuxmint)
ID=$(cat /etc/os-release | grep -w ID | cut -d= -f2 | tr -d '"')
if [ $ID = "debian" ];then
  VERSION_CODENAME=$(cat /etc/os-release | grep -w VERSION_CODENAME | cut -d= -f2 | tr -d '"')
  REPO=$(cat /etc/apt/sources.list | grep "^deb http://deb.debian.org/debian/ $VERSION_CODENAME ")
  if [[ $REPO =~ contrib ]];then
    sudo apt install -y wget winetricks
  else
    echo 'The "contrib" repository should be enabled to install winetricks'
    echo 'add the word contrib to the end of the following line in the file /etc/apt/sources.list'
    echo
    echo $REPO
    echo
    exit
  fi
fi
if [ $ID = "fedora" ];then
  VERSION_ID=$(cat /etc/os-release | grep -w VERSION_ID | cut -d= -f2 | tr -d '"')
  if [[ $VERSION_ID -gt 40 ]];then
    sudo dnf install -y python3-libdnf5  # Ansible does not (yet) understand dnf5
  fi
fi
if [[ ${LIKE_DEBIAN[@]} =~ $ID ]];then
  sudo apt install -y python3-venv git
fi

# Create and activate Python virtual environment
python3 -m venv ~/roon_venv
source ~/roon_venv/bin/activate

# Install Ansible using PIP
pip install ansible python-debian

# Clone github repo
if [ ! -d ~/roon_venv/gui ];then
  git clone https://github.com/oosten246/ansible-roon-gui ~/roon_venv/gui
fi

# Install Ansible roles
ansible-galaxy install -r ~/roon_venv/gui/requirements.yml

# Run Ansible playbook
ansible-playbook  ~/roon_venv/gui/roon-gui.yml --ask-become-pass