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
