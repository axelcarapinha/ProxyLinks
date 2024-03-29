source src/configs/config.conf

# Function: avoid_repeated_builds
#
# Description:
#   Warns the user that there's already a container
#   with the name of the pretended to be use by Proxylinks
#
# Parameters:
#   $1: name of the container that Proxylinks pretends 
#   to build with Docker
#
# Returns:
#   Nothing (std output)
#
# Usage:
#   avoid_repeated_builds "name_of_container"
#
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

#
# Creating the buildx container
#
avoid_repeated_builds "proxylinks-builder"
#
sudo docker buildx create --name proxylinks-builder
sudo docker buildx use proxylinks-builder
sudo docker buildx build \
    -t proxylinks-container-image \
    -f Dockerfile . \
    --load

#
# To save the image to a .tar file
#
# docker save -o proxylinks-container-image.tar proxylinks-container-image
# exit 0


#
# Building and runnning Proxylinks' container
#
avoid_repeated_builds "proxylinks-container"
#
sudo docker run \
    --name proxylinks-container \
    -it \
    -v "$PATH_TO_SSH_KEY":/root/.ssh proxylinks-container-image \
    bash main.bash




