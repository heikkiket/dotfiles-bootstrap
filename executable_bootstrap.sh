#!/bin/bash
# Create a SSH key and Bootstrap Chezmoi

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

# Very essential packages
PACKAGES="xclip git"

# Used when generating a key for Github
SSH_KEYTYPE="ed25519"

sudo apt install $PACKAGES

EMAIL=`ask_default "Give an email address to use in SSH key:" "heikki.ketoharju@iki.fi"`

## Configure SSH ##

banner "Creating a SSH key for Github"

ssh-keygen -t $SSH_KEYTYPE -b 4096 -C "$EMAIL"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_$SSH_KEYTYPE

URL=https://github.com/settings/ssh/new
xclip -sel clip < ~/.ssh/id_$SSH_KEYTYPE.pub
banner "SSH Key copied to the clipboard. Go to $URL
and paste it there."
echo "Do you want to open that URL in a browser?"
if answer_yes; then
	open $URL >/dev/null 2>&1
fi
read -p "[When Done, Press ENTER to continue]";

banner "Installing Chezmoi to $HOME/.local/bin"
sh -c "$(wget -qO- get.chezmoi.io/lb)" -- -b $HOME/.local/bin
