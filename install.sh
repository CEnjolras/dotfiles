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

exec > /dev/null 2>&1

#====================
# Functions
#====================
ADMIN="$(id -nu 1000)"
HOME="/home/$ADMIN"

info_print () {
    echo -e "${BOLD}${BGREEN}[ ${BYELLOW}•${BGREEN} ] $1${RESET}"
}


#====================
# 2 - Pacman & yay
#====================

info_print "Setup pacman & yay : fastest mirrors, enable colors, parallel downloads, system update..."

# Setting up reflector
info_print "Setting up reflector..."
sudo pacman -S --needed --noconfirm reflector && sudo systemctl enable --now reflector.timer && sudo reflector --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist


# Enabling colors and setting up parallelDownloads
info_print "Enabling colors and parallel downloads..."
sed -Ei 's/^#(Color)$/\1\n#ILoveCandy/;s/^#(ParallelDownloads).*/\1 = 10/' /etc/pacman.conf

# System upgrade
info_print "System upgrade..."
pacman -Syyu

# Installing yay
info_print "Installing yay..."
pacman -S --noconfirm --needed git base-devel
git clone https://aur.archlinux.org/yay.git && (cd yay && makepkg -si --noconfirm) && rm -rf yay


# Clearing cache from time to timerm
info_print "Adding pacman hook to clear cache..."
sudo pacman -S --noconfirm pacman-contrib
curl -L --create-dirs -o $HOME/.local/bin/yaycache https://bit.ly/yaycache && chmod +x $HOME/.local/bin/yaycache
[ -f "$HOME/.bashrc" ] && grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc" && source "$HOME/.bashrc"



#====================
# 1 - Git
#====================

git config --global user.name  "Clément Enjolras"
git config --global user.email "enj.clement@gmail.com"




# 3 install microcode

# pacman -S intel-ucode
# grub-mkconfig -o /boot/grub/grub.cfg