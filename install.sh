#!/bin/bash
#
# Setups arch linux for me.
#
# Steps:
# 1 - Setup pacman : 
#	- Install reflector, setup fastest mirrors, and checks for fastest mirror every week
#	- Enable colors and parallel downloads
#	- Adding pacman hook to clear cache
#	- Performs a system upgrade

#====================
# Functions
#====================
ADMIN="$(id -nu 1000)"
HOME="/home/$ADMIN"

info_print () {
    echo -e "${BOLD}${BGREEN}[ ${BYELLOW}•${BGREEN} ] $1${RESET}"
}



#====================
# 2 - Important packages
#====================
info_print "Install important packages"
sudo pacman -S git base-devel --noconfirm

#====================
# 2 - Pacman & yay
#====================

info_print "Setup pacman & yay : fastest mirrors, enable colors, parallel downloads, system update..."

# Setting up reflector
info_print "Setting up reflector..."
sudo pacman -S --noconfirm reflector && sudo systemctl enable --now reflector.timer && sudo reflector --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist


# Enabling colors and setting up parallelDownloads
info_print "Enabling colors and parallel downloads..."
sed -Ei 's/^#(Color)$/\1\n#ILoveCandy/;s/^#(ParallelDownloads).*/\1 = 10/' /etc/pacman.conf

# System upgrade
info_print "System upgrade..."
pacman -Syyu

# Installing yay
info_print "Installing yay..."
git clone https://aur.archlinux.org/yay.git && (cd yay && makepkg -si --noconfirm) && rm -rf yay


# Dealing with pacman and yay cache...
info_print "Dealing with pacman and yay cache..."
sudo pacman -S --noconfirm pacman-contrib
# Downloading cleaning script
curl -L --create-dirs -o $HOME/.local/bin/yaycache https://github.com/CEnjolras/dotfiles/blob/main/install/yaycache && chmod +x $HOME/.local/bin/yaycache
touch $HOME/.bashrc && echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc" && source "$HOME/.bashrc"
# Hooking it to pacman upgrades and uninstallations
sudo curl -L --create-dirs -o /usr/share/libalpm/hooks/yaycache.hook https://github.com/CEnjolras/dotfiles/blob/main/install/yaycache.hook


#====================
# 1 - Git
#====================
info_print "Git basic config..."
git config --global user.name  "Clément Enjolras"
git config --global user.email "enj.clement@gmail.com"




# 3 install microcode

# pacman -S intel-ucode
# grub-mkconfig -o /boot/grub/grub.cfg