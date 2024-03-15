#!/bin/bash

#
# Settings 
#
SHELL="zsh" 
PORT=1337
HOST="localhost"

variables=("port" "host")
PORT_IDX=0
HOST_IDX=1
#
CLEAN_TERMINAL="\033[2J" # escape sequence to clean the terminal

#
# Functions
#
function explainProgram() {
	printf "Flags: \n"
	printf "\t '-s' or '--set'    (...the proxy) \n"
	printf "\t '-v' or '--verify' (...current state) \n"
	printf "\t '-r' or '--reset'  (...to default state) \n"
	printf "\t '-e' or '--exit'   (...the proxy) \n"
	printf "\n"
	printf "\t '-h' or '--help'\n"
	printf "\t '-c' or '--curiosity' \n"
	printf "\t 'Ctrl-L' or 'clear' to clean CLI's view"
	printf "\n"
	printf "\t Ctrl-C to finish the execution. \n"
}

function createTerminalTab() {
	x-terminal-emulator \
		--name "ProxyLinks CLI" \
		--title "ProxyLink - happy coding ;)" \
		--start-as normal \
		--hold \
		-- sh \
		-c "$1" \
		-c "$2"
}

# "&> /dev/null" (both stdout and stderr are not visible with this)
# ping -c 1 (amount of packets sent)
function isServerUp() {
	target="${!1}" # indirect variable expansion needed
	numPackets="${!2}"
	if ping -c $numPackets "$target" &> /dev/null; then
    	return 0
	else
    	return 1 # in bash, any other value than 0 is considered false
	fi
}
#
function knowCurrIpLocation() {
	userWantsCycle=$([[ "$1" == "y" || "$1" == "Y" ]] && echo true || echo false)

	URL_GEO_IP_API="http://ip-api.com/json/"
	DOMAIN_GEO_IP_API="ip-api.com"
	numPackets=1

	if isServerUp DOMAIN_GEO_IP_API numPackets; then # sent it this way just to practice indirect variable expansion
		jsonContent=$(curl -s "$URL_GEO_IP_API")
		country=$(echo "$jsonContent" | jq -r '.country')
		region=$(echo "$jsonContent" | jq -r '.regionName')
		echo "Location: $region, $country"
	else
		echo "Server down. Unable to know IP location."
	fi

	# Get the location again in 60 seconds
	if [[ userWantsCycle ]]; then
		sleep 60
		knowCurrIpLocation "y" & # keep running in the background
	fi
}
#
function setProxy() {
	# In case the proxy settings are in "Disabled mode"
	gsettings set org.gnome.system.proxy mode 'manual';

	printf "Setting... \n"
	gsettings set org.gnome.system.proxy.socks ${variables[$PORT_IDX]} $PORT # 1337 (default)
	gsettings set org.gnome.system.proxy.socks ${variables[$HOST_IDX]} $HOST # localhost (default)

	#TODO use a file instead of the ssh command that was here
	createTerminalTab ""
}
#
function verifyCurrState() {
	printf "Verifying... \n"
	for property in "${variables[@]}"; do
    	echo " $property = $(gsettings get org.gnome.system.proxy.socks "$property")"
	done
}
#
function resetProxySettings() {
	execReset() { 
		echo "Resetting proxy settings..."
		gsettings set org.gnome.system.proxy mode 'none'; 
	}

	if [[ -n "$1" && "$1" = "-y" ]]; then
		execReset
	else 
		printf "Are you sure? [y/n] "
		read ANSWER
		if [ "$ANSWER" = "y" ] || [ "$ANSWER" = "Y" ] || [ "$1" = "-y" ]; then	
			execReset
		else
			echo "Did NOT reset the proxy settings."
		fi
	fi
}

function outputCuriosity() {
	echo "The term \"proxy\" originated from the Latin word \"proximus,\" meaning \"next." 
}

function clearTerminal() { echo -e "$CLEAN_TERMINAL"; }

#
# Simple interface
#
function userActions() {
	FLAG=$1

	case "$FLAG" in 
		"-s" | "-S" | "--set")
			setProxy
			;;
		"-v" | "-V" | "--verify")
			verifyCurrState
			;;
		"-r" | "-R" | "--reset")
			resetProxySettings $2
			;;	
		"-e" | "-E" | "--exit")
			exitProxy
			;;
		"-h" | "-H" | "--help")
			explainProgram
			;;
		"-c" | "-C" | "--curiosity")
			outputCuriosity
			;;
		"^L" | "--clear")
			clearTerminal
			;;
		"l" | "--location")
			read -p "Do you want to have a cyclic verification? [y / n] " userResponse
			knowCurrIpLocation userResponse
			;;
		*)	
			echo "Invalid flag. Please, try again."
			;;
	esac
}

user_input=$1 # argument of the command line
if [[ -z $user_input ]]; then
	echo "Enter '-h' if you want to know the available commands"
fi

while true; do
    if [[ -z $user_input ]]; then
        read -p "Command:  " user_input  
		clearTerminal
    else
        userActions "$user_input"
		unset user_input
    fi
done

echo "Execution finished successfully"
