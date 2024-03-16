# Function: is_server_up
#
# Description:
#   Check if the server to which we want to connect is up 
#
# Parameters:
#   None
#
# Returns:
#   server_is_up (boolean) - true if the connection succeeded 
#   false otherwise
#
# Usage:
#   is_server_up
#
function is_server_up() {
    local server_is_up=1

	local target="${!1}" # indirect variable expansion needed
	local NUM_PACKETS="${!2}"

	if ping -c $NUM_PACKETS "$target" &> /dev/null; then
    	server_is_up=0
	fi

    return $server_is_up;
}


# Function: verify_curr_settings
#
# Description:
#   Prompts the current proxy settings of the gnome environment
#
# Parameters:
#   None
#
# Returns:
#   Nothing (std output)
#
# Usage:
#   verify_curr_settings
#
function show_proxy_settings() {
	printf "Verifying... \n"
	for property in "${variables[@]}"; do
    	echo " $property = $(gsettings get org.gnome.system.proxy.socks "$property")"
	done
}


# Function: create_terminal_tab
#
# Description:
#   Create the terminal emulator window, where the user
#   can interact with its proxy server directly 
#   after the connection is established
#
# Parameters:
#   $1: command to connect to the server (ssh, https, ...)
#
# Returns:
#   Nothing (std output)
#
# Usage:
#   create_terminal_tab
#
function create_terminal_tab() {
	x-terminal-emulator \
		--name "ProxyLinks CLI" \
		--title "ProxyLink - happy coding ;)" \
		--start-as normal \
		--hold \
		-- sh \
		-c "$1" 
}


# Function: set_proxy
#
# Description:
#   Prepares the settings for the new connection with the server,
#   and establishes it,
#   considering the .conf file
#
# Parameters:
#   None
#
# Returns:
#   Nothing
#
# Usage:
#   set_proxy
#
function set_proxy() {
	# In case the proxy settings are in "Disabled mode"
	gsettings set org.gnome.system.proxy mode 'manual';

	printf "Setting... \n"
	gsettings set org.gnome.system.proxy.socks ${variables[$PORT_IDX]} $PORT # 1337 (default)
	gsettings set org.gnome.system.proxy.socks ${variables[$HOST_IDX]} $HOST # localhost (default)

	create_terminal_tab "ssh -i \"~/Desktop/Link\ to\ (1.0)\ Coding/1MAGIC/0Server\" "$SERVER_USERNAME"@"$SERVER_IP"; exec zsh"
}


# Function: reset_proxy_settings
#
# Description:
#   Disables the proxy settings through the gsettings API,
#   ideal after the user wants to disconnect from the proxy server
#
# Parameters:
#   $1: user pre-response to the confirmation question
#
# Returns:
#   Nothing (std output)
#
# Usage:
#   reset_proxy_settings
#
function reset_proxy_settings() {
    local user_wants_reset=${1:-"-n"} # default answer

    exec_reset() { 
        echo "Resetting proxy settings..."
        gsettings set org.gnome.system.proxy mode 'none'; 
    }

    if [[ "$user_wants_reset" =~ -[yY] ]]; then
        exec_reset
    else 
        read -p "Are you sure? [y/n] " answer
        if [[ "$answer" =~ -[yY] ]]; then    
            exec_reset
        else
            echo "Did NOT reset the proxy settings."
        fi
    fi
}


# Function: know_curr_ip_location
#
# Description:
#   Gets the current API location JSON data from a public API
#   and displays it in a readable manner
#
# Parameters:
#   $1: user response, to know 
#   if he wants to keep knowing the location in loop
#
# Returns:
#   Nothing (std out)
#
# Usage:
#   know_curr_ip_location -y
#
function know_curr_ip_location() {
    local user_response 

	read -p "Do you want to have a cyclic verification? [y / n] " user_response

	local userWantsCycle=$([[ "$user_response" =~ "-[yY]" ]] && echo true || echo false)

	local readonly URL_GEO_IP_API="http://ip-api.com/json/"
	local readonly DOMAIN_GEO_IP_API="ip-api.com"
	local readonly NUM_PACKETS=1

	if is_server_up DOMAIN_GEO_IP_API NUM_PACKETS; then # sent it this way just to practice indirect variable expansion
		local jsonContent=$(curl -s "$URL_GEO_IP_API")
		local country=$(echo "$jsonContent" | jq -r '.country')
		local region=$( echo "$jsonContent" | jq -r '.regionName')
		echo "Location: $region, $country"
	else
		echo "Server down. Unable to know IP location."
	fi

	# Get the location again in 60 seconds
	if [[ userWantsCycle ]]; then
		sleep 60
		know_curr_ip_location "-y" & # keep running in the background
	fi
}



