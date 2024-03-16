#!/bin/bash

#
# Imports
#
source configs/config.conf
source configs/logger.bash
#
source handlers/request_handler.bash
source request_forwarder.bash
source handlers/response_handler.bash
#
source handlers/error_handler.bash


# Function: user_actions
#
# Description:
#   Calls the function respective to the flag (the command)
#	entered by the user
#
# Parameters:
#   $1: the pretended command (invalid or not)
#
# Returns:
#   Nothing
#
# Usage:
#   user_actions --set
#
function user_actions() {
	FLAG=$1
	case "$FLAG" in 
		"-s" | "-S" | "--set")
			set_proxy "$VISUAL_MODE" #TODO check this
			;;
		"-v" | "-V" | "--verify")
			show_proxy_settings #TODO verify if in a container the errors still occur
			;;
		"-r" | "-R" | "--reset")
			reset_proxy_settings $2
			;;
		"-h" | "-H" | "--help")
			explain_script
			;;
		"-c" | "-C" | "--curiosity")
			output_curiosity
			;;
		"^L" | "--clear")
			clear_terminal
			;;
		"l" | "--location")
			know_curr_ip_location 
			;;
		*)	
			echo "Invalid flag. Please, try again."
			;;
	esac
}

#
# Main
#
function main() {
	#
	# Terminate child processes (of know_curr_ip_location) when this script ends
	# 
	trap 'kill $(jobs -p)' EXIT 

	#
	# Execution
	#
	local user_input=$1 
	if [[ -z $user_input ]]; then
		echo "Enter '-h' if you want to know the available commands"
	fi
	#
	while true; do
		if [[ -z $user_input ]]; then
			read -p "command:  " user_input  

			# Handle the case where the user 
			# comments out this variable in config.conf
			if [[ -v CLEAN_TERMINAL ]]; then
				clear_terminal
			fi
		else
			user_actions "$user_input"
			unset user_input
		fi
	done

	#
	# Gracefully finish the execution
	#
	#TODO consider more security options
	reset_proxy_settings
	echo "Execution finished successfully"
}
#
main "$@" 
