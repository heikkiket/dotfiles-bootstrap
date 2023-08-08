#!/bin/bash
# INSTALL Everything

################### SUBROUTINES #######################
function ask_default()
{
    read -p "$1 [default: $2]> " INPUT
    if [ -z "$INPUT" ]; then
        echo $2;
    else
        echo "$INPUT";
    fi;
}

function banner()
{
    echo
    echo
    echo "********************************************************************************"
    echo "$1"
    echo "********************************************************************************"
}

function answer_yes()
{
	  read -p "[y/n]?" INPUT
	  if [ $INPUT == "y" ]; then
		    return 0
	  else
		    return 1
	  fi
}

################### END SUBROUTINES #######################

banner "Do you want to setup your whole system now? You know, Ansible and stuff... I really recommend you to do that, but of course you can turn around now and do something else instead."
if answer_yes; then
    echo "I knew you're such person!"
else
    echo "Brave brave brave sir Robin!"
    exit 0
fi

banner "Installing Ansible"
sudo apt update
sudo apt install ansible -y

banner "Lifting your system up with Ansible"
cd ~/.my-dotfiles/ansible
ansible-playbook system.yml

banner "Now you have to log out and back in. Do you want to do it now?"
if answer_yes; then
	gnome-session-quit
fi
exit 0
