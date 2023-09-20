#!/bin/bash

# Check if pacman-contrib is already installed
if ! pacman -Qs pacman-contrib > /dev/null; then
  echo "Installing pacman-contrib..."
  sudo pacman -S pacman-contrib --noconfirm
else
  echo "pacman-contrib is already installed."
fi

echo "Installing yay..."
git clone https://aur.archlinux.org/yay.git && (cd yay && makepkg -si --noconfirm) && rm -rf yay