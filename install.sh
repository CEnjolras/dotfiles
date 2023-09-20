#!/bin/bash
#
# Setups arch linux for me.
#

# 1 - Installing ansible
#sudo pacman -S ansible --noconfirm

# 2 - Downloading and playing ansible playbook
wget https://raw.githubusercontent.com/CEnjolras/dotfiles/main/playbook.yml playbook.yml
ansible-playbook playbook.yml --ask-become-pass
