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

git clone https://github.com/jskhtakeda/dotfiles.git ~/dotfiles
mv ~/.bashrc ~/.bashrc.back
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/init.el ~/.emacs.d/init.el

# install ROS

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://ha.pool.sks-keyservers.net:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt update
yes | sudo apt install ros-kinetic-desktop-full
sudo rosdep init
rosdep update
yes | sudo apt install python-rosinstall
yes | sudo apt install ros-kinetic-rosemacs

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
