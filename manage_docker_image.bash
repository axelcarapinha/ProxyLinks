#!/bin/bash
# Creates the container to use ProxyLinks

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

# Create the builder container
avoid_repeated_builds "$DOCKER_BUILDER_NAME"
sudo docker buildx create --name "$DOCKER_BUILDER_NAME"
sudo docker buildx use "$DOCKER_BUILDER_NAME"
sudo docker buildx build --platform linux/amd64 -t "$DOCKER_IMAGE_NAME":latest --load .

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    log_error "SSH agent is not running" -1
fi

sudo docker run -v /ssh-agent:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent "$DOCKER_IMAGE_NAME"