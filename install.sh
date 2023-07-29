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
info_print () {
    echo -e "${BOLD}${BGREEN}[ ${BYELLOW}•${BGREEN} ] $1${RESET}"
}


#====================
# 1 - Pacman
#====================

info_print "Setup pacman : fastest mirrors, enable colors, parallel downloads, system update..."

# Setting up reflector
pacman -S reflector
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
systemctl enable reflector.timer

# Enabling colors and setting up parallelDownloads
sed -Ei 's/^#(Color)$/\1\n#ILoveCandy/;s/^#(ParallelDownloads).*/\1 = 10/' /etc/pacman.conf

# Clearing cache from time to time
pacman -S pacman-contrib

curl -L --create-dirs -o ~/.local/bin/yaycache URL

# System upgrade
pacman -Syyu




# 3 install microcode

pacman -S intel-ucode
grub-mkconfig -o /boot/grub/grub.cfg