#!/bin/bash
# INSTALL Everything

# Include banner subroutine:
source $(dirname "$0")/lib.sh

banner "Installing Ansible"
sudo apt update
sudo apt install ansible -y

banner "Lifting your system up with Ansible"
cd ~/.my-dotfiles/ansible
ansible-playbook system.yml
exit 0
