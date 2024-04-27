#!/bin/bash
# Interpret user input commands.

source configs/config.conf
source utils_proxy

function output_curiosity() {
	echo "The term \"proxy\" originated from the Latin word \"proximus\", meaning \"next\"." 
}

function explain_script() {
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
	printf "\t 'Ctrl-C' to finish the execution. \n"
}

#TODO consider an array for this
function parse_input_commands() {
	local readonly FLAG=$1
	local readonly CONFIRMATION=$2 # a -y flag to skip questions and allow execution

	case "$FLAG" in 
		"-s" | "-S" | "--set")    proxy_start ;;
		"-v" | "-V" | "--verify") proxy_verify_settings ;;
		"-r" | "-R" | "--reset")  proxy_reset "$CONFIRMATION" ;;
		"-l" | "--location")      know_curr_ip_location ${CYCLE_TIME} ;; 
		"-h" | "-H" | "--help")   explain_script ;;
		"-c" | "-C" | "--curiosity") output_curiosity ;;
		"^L" | "--clear") clear_terminal ;;
		*) echo "Invalid flag. Please, try again." ;;
	esac

	return 0
}


function main() { 
	trap '[[ $VERBOSE -eq 1 ]] && kill $(jobs -p) > /dev/null 2>&1' EXIT
	trap '[[ $VERBOSE -eq 1 ]] && reset_proxy_settings; exit 1' SIGINT

	# Prepare a graceful termination (all jobs and settings back to normal)
	trap 'kill $(jobs -p)' EXIT 
	trap 'proxy_reset; exit 1' SIGINT 

	local user_input="$1" 
	if [[ -z $user_input ]]; then
		[[ VERBOSE -eq 1 ]] && echo "Enter '-h' if you want to know the available commands\n Ctrl-C to terminate"
	fi

	# Start the proxy 
	proxy_start
	local readonly WANT_CYCLE=1
	know_curr_ip_location "$WANT_CYCLE" 

	# Listen for more commands
	while true; do 
		if [[ -z $user_input ]]; then
			read -p "command:  " user_input  
		else
			parse_input_commands "$user_input"
			unset user_input
		fi
	done

	return 0;
}
main "$@"


#TODO colors for errors and interface