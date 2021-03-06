#!/bin/bash

# apt update
yes | sudo apt update
yes | sudo apt upgrade

# capslock -> ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

# download chrome
# manual: https://www.google.com/chrome/?hl=ja

# apt install
yes | sudo apt install git emacs24

# replace dotfiles
git clone git@github.com:hi-takeda/dotfiles.git ~/dotfiles
mv ~/.bashrc ~/.bashrc.back
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/init.el ~/.emacs.d/init.el
touch ~/dotfiles/.rossourcelast
ln -sf ~/dotfiles/.rossourcelast ~/.rossourcelast
echo "/opt/ros/kinetic/setup.bash" > ~/.rossourcelast

# install ROS
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://ha.pool.sks-keyservers.net:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt update
yes | sudo apt install ros-kinetic-desktop-full
sudo rosdep init
rosdep update
yes | sudo apt install python-rosinstall
yes | sudo apt install ros-kinetic-rosemacs
yes | sudo apt install python-catkin-tools

# emacs
# manual: install packages by "M-x package-list-packages"
# manual: to use ctrl + space: click langeuage bar top right of window -> configure -> global configure -> change "ctrl + space" to "Zenkakuhankaku"
# manual: to use ctrl + alt + b: sudo emacs -nw /usr/share/fcitx/addon/fcitx-vk.conf -> Enabled=False
yes | sudo apt install xsel # for sharing clipboard

# terminal
# manual: menu -> profile setting -> color -> NOT use system theme color -> white character on black back -> set transmission by bar

# trackpoint
# manual: win -> search by "dash" -> "xinput --set-prop 10 "Device Accel Constant Deceleration" 0.35

# install gnome-open
yes | sudo apt install libgnome2-bin

# install xclip
yes | sudo apt install xclip

# ssh
# fix ip with GUI
ssh-keygen -t rsa # and upload .ssh/id_rsa.pub to github
# manual: /etc/ssh/sshd_config ssh-copy-id under "PasswordAuthentication yes" -> modify "PasswordAuthentication no" # "sudo service sshd restart" is needed
# should be "PermitRootLogin no"
# add name .ssh/config

# GPU
# win -> software and update -> add driver -> if nothing, then...
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
# win -> software and update -> add driver -> choose proper driver and install it

# Monitoring CPU, memory, net, disk using
yes | sudo apt install indicator-multiload

# do NOT distinct oomoji komoji
echo "set completion-ignore-case on" >> /etc/inputrc # then C-x, C-r on terminal

# keyboard shortcut
sudo apt install  compizconfig-settings-manager # window management -> grid

# stop warning "System problem detected"
sudo rm /var/crash/*
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport
