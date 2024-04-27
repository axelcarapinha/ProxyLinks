#!/bin/bash
# Creates a container to use ProxyLinks

source configs/config.conf
source src/utils_general

#######################################
# Avoids reusing names of containers
# during the build process of the image
#
# Globals:
#   VERBOSE (flag for the verbose mode)
# Arguments:
#   $1: name of the container that Proxylinks
#   pretends to build with Docker
# Outputs:
# 	Nothing in case there is no conflict,
#   interface to solve the problem otherwise
#######################################
function avoid_repeated_builds() {
    local readonly TARGET_CONTAINER="$1"
    if sudo docker buildx ls | grep -q "$TARGET_CONTAINER"; then
        echo "There's already a container with that name"
        read -p "Remove it and build a new one with Proxylinks? (y/n): " answer
        if [[ "$answer" =~ [yY] ]]; then
            sudo docker buildx stop "$TARGET_CONTAINER"
            sudo docker buildx rm -f "$TARGET_CONTAINER"
        fi
    fi
}


#TODO######################################
# Checks the existence of the secret
# before passing to Docker compose
#
# Globals:
#   SSH_PRIVATE_KEY_PATH
# Arguments:
#   None
# Outputs:
# 	Success if the secret exists at the 
#   specified path, error otherwise
#######################################
function check_secret_existence() {
    if [[ -z "$SSH_PRIVATE_KEY_PATH" ]]; then
        log_error "Error, empty secret path detected" 1
        exit 1
    fi

    # if [[ ! -f "$SSH_PRIVATE_KEY_PATH" ]]; then
    #     log_error "Error, secret not found at specified path" 2
    #     exit 2
    # fi

    return 0;
}

# Create the builder container
avoid_repeated_builds "$DOCKER_BUILDER_NAME"
sudo docker buildx create --name "$DOCKER_BUILDER_NAME"

check_secret_existence "$SSH_PRIVATE_KEY_PATH" #TODO solve the path problem
cat "${HOME}/.ssh/tester_azure_server.pem" | sudo docker secret create ssh_key -

sudo docker compose --env-file ./config/.env.dev up
sudo docker-compose run --rm --entrypoint bash proxylinks-container