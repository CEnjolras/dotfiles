#!/bin/bash
#
# Setups arch linux for me.
#

# 1 - Installing ansible and wget
#sudo pacman -S ansible --noconfirm

# 2 - Downloading and playing ansible playbook
curl -o playbook.yml https://raw.githubusercontent.com/CEnjolras/dotfiles/main/playbook.yml
ansible-playbook playbook.yml --ask-become-pass
