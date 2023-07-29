#!/bin/bash
#
# Setups arch linux for me.
#
# Steps:
# 1 - Important packages
# 2 - Setup pacman : 
#	- Install reflector, setup fastest mirrors, and checks for fastest mirror every week
#	- Enable colors and parallel downloads
#	- Adding pacman hook to clear cache
#	- Performs a system upgrade
# 3 - Install microcode

#====================
# Functions
#====================
ADMIN="$(id -nu 1000)"
HOME="/home/$ADMIN"

info_print () {
    echo -e "${BOLD}${BGREEN}[ ${BYELLOW}•${BGREEN} ] $1${RESET}"
}



#====================
# 1 - Important packages
#====================
info_print "Install important packages"
sudo pacman -S git base-devel --noconfirm

#====================
# 2 - Pacman & yay
#====================

# Setting up reflector
info_print "Setting up reflector..."
sudo pacman -S --noconfirm reflector && sudo systemctl enable --now reflector.timer && sudo reflector --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist


# Enabling colors and setting up parallelDownloads e
info_print "Enabling colors and parallel downloads..."
sed -Ei 's/^#(Color)$/\1\n#ILoveCandy/;s/^#(ParallelDownloads).*/\1 = 10/' /etc/pacman.conf

# System upgrade
info_print "System upgrade..."
pacman -Syyu

# Installing yay
info_print "Installing yay..."
git clone https://aur.archlinux.org/yay.git && (cd yay && makepkg -si --noconfirm) && rm -rf yay
yay --save --answerdiff None --answerclean None --removemake

# Dealing with pacman cache
info_print "Dealing with pacman and yay cache..."
sudo systemctl enable paccache.timer
#sudo pacman -S --noconfirm pacman-contrib
#sudo curl -L --create-dirs -o /usr/share/libalpm/hooks/clear_cache.hook https://raw.githubusercontent.com/CEnjolras/dotfiles/main/install/clear_cache.hook


#====================
# 3 - install microcode
#====================

info_print "Installing microcode..."
cpu_vendor=$(lscpu | grep -oP 'Vendor ID:\s+\K.*')
if [ "$cpu_vendor" = "GenuineIntel" ]; then
  info_print "Detected Intel CPU. Installing intel-ucode..."
  sudo pacman -S --needed intel-ucode --noconfirm
elif [ "$cpu_vendor" = "AuthenticAMD" ]; then
  info_print "Detected AMD CPU. Installing amd-ucode..."
  sudo pacman -S --needed amd-ucode --noconfirm
else
  echo "Unknown CPU vendor. Microcode installation not supported."
fi


#====================
# 4 - Hyprland
#====================
# install hyprland
info_print "Installing hyprland..."
yay -S hyprland --noconfirm

#====================
# 1 - Git
#====================
info_print "Git basic config..."
git config --global user.name  "Clément Enjolras"
git config --global user.email "enj.clement@gmail.com"

#====================
# 1 - Todo
# - SDDM
# - Remove grub delay
# - Fonts
# - Terminal
# - waybar
# - notifications
# - asking for password visually
#====================
# SDDM
# sudo pacman -S sddm
# systemctl enable sddm.service
# Remove grub delay