#!/bin/bash
# Starts the interface, interpretates user commands and cleans when finished

source configs/config.conf
source src/interface
source src/utils_proxy

function main() { 
	# Prepare a graceful termination (all jobs and settings back to the normal)
	trap '[[ $VERBOSE -eq 1 ]] && kill $(jobs -p) > /dev/null 2>&1' EXIT
	trap '[[ $VERBOSE -eq 1 ]] && proxy_reset; exit 1' SIGINT

	# Prepare the SHH agent 
	if ! in_container; then
		prepare_ssh_agent
	fi
	# (the container mode already does this)

	# Output the first details
	local user_input="$1" 
	output_title
	if [[ -z $user_input ]]; then
		if [[ VERBOSE -eq 1 ]]; then
			echo "Enter '-h' if you want to know the available commands"
			echo "Ctrl-C to terminate"
		fi
	fi

	# Listen for more commands (until Ctrl-C is used by the user)
	while true; do 
		if [[ -z $user_input ]]; then
			printf "${BLUE}> ${RESET}"
			read user_input
		else
			parse_input_commands "$user_input"
			unset user_input
		fi
	done

	return 0;
}
main "$@"