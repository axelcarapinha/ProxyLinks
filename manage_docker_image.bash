#!/bin/bash
# Creates a container to use ProxyLinks

source ../src/configs/config.conf

#######################################
# Avoids reusing names of containers
# during the build process of the image
#
# Globals:
#   None
# Arguments:
#   $1: name of the container that Proxylinks
#   pretends to build with Docker
# Outputs:
# 	Nothing in case there is no conflict,
#   interface to solve the problem otherwise
#######################################
function avoid_repeated_builds() {
    local TARGET_CONTAINER="$1"
    if sudo docker ps -a | grep "$TARGET_CONTAINER"; then
        echo "There's already a container with that name"
        printf "Remove it and build a new one with Proxylinks? (y/n): "
        read answer
        if [[ "$answer" =~ [yY] ]]; then
            sudo docker stop "$TARGET_CONTAINER"
            echo "Removed '$(sudo docker rm -f "$TARGET_CONTAINER")'"
        fi
    fi
}

# Create the builder container
avoid_repeated_builds "proxylinks-builder"
sudo docker buildx create --name proxylinks-builder
sudo docker buildx use proxylinks-builder
sudo docker buildx build \
    --builder proxylinks-builder \
    -t proxylinks-container-image \
    -f Dockerfile . \
    --load

# Save the image to a .tar file
# docker save -o proxylinks-container-image.tar proxylinks-container-image
# exit 0

# Build and run Proxylinks' container
avoid_repeated_builds "proxylinks-container"
#
cat "$SSH_PRIVATE_KEY_PATH" | docker secret create ssh_key -
sudo docker run \
    --name proxylinks-container \
    -it \
    --mount type=secret,source=ssh_key,target=/root/.ssh/id_rsa \
    proxylinks-container-image \
    bash main.bash


