# Function: explain_script
#
# Description:
#   Explains the accepted inputs to the user
#
# Parameters:
#   $1: a flag for the pretended command
#
# Returns:
#   Nothing (std output)
#
# Usage:
#   explain_script --set 
#
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


# Function: output_curiosity
#
# Description:
#   Explains the origin of the term "proxy"
#
# Parameters:
#   None
#
# Returns:
#   Nothing (std output)
#
# Usage:
#   output_curiosity
#
function output_curiosity() {
	echo "The term \"proxy\" originated from the Latin word \"proximus\", meaning \"next\"." 
}


# Function: clear_terminal
#
# Description:
#   Clears the terminal after new command input
#
# Parameters:
#   None
#
# Returns:
#   Nothing (std output)
#
# Usage:
#   clear_terminal
#
function clear_terminal() { echo -e "$CLEAN_TERMINAL"; }

