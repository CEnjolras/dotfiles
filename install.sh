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

info_print () {
    echo -e "${BOLD}${BGREEN}[ ${BYELLOW}•${BGREEN} ] $1${RESET}"
}


#====================
# 2 - Pacman & yay
#====================

info_print "Setup pacman & yay : fastest mirrors, enable colors, parallel downloads, system update..."

# Setting up reflector
pacman -S --noconfirm reflector
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
systemctl enable reflector.timer

# Enabling colors and setting up parallelDownloads
sed -Ei 's/^#(Color)$/\1\n#ILoveCandy/;s/^#(ParallelDownloads).*/\1 = 10/' /etc/pacman.conf

# System upgrade
pacman -Syyu

# Installing yay
pacman -S --noconfirm --needed git base-devel && git clone https://aur.archlinux.org/yay.git ~/yay && ( cd ~/yay && su - $ADMIN -c makepkg -si ) && rm -rf ~/yay

# Clearing cache from time to time
pacman -S --noconfirm pacman-contrib
curl -L --create-dirs -o ~/.local/bin/yaycache https://bit.ly/yaycache && chmod +x ~/.local/bin/yaycache
touch ~/.bashrc && grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc


#====================
# 1 - Git
#====================

git config --global user.name  "Clément Enjolras"
git config --global user.email "enj.clement@gmail.com"




# 3 install microcode

# pacman -S intel-ucode
# grub-mkconfig -o /boot/grub/grub.cfg