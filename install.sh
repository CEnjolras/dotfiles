#!/bin/bash
#
# Setups arch linux for me.
#

# 1 - Installing ansible and wget
sudo pacman -S ansible --noconfirm

# 2 - Downloading and playing ansible playbook
curl -o main.yml -H "Cache-Control: no-cache" https://raw.githubusercontent.com/CEnjolras/dotfiles/main/main.yml
ansible-playbook main.yml --ask-become-pass
