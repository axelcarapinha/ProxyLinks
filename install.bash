#
# Creating the buildx container
#
sudo docker buildx create --name proxylinks-builder
sudo docker buildx use proxylinks-builder
sudo docker buildx build \
    -t proxylinks-container-image \
    -f Dockerfile . \
    --load

# The command above is deprecated, only only when strictly necessary
# sudo docker build -t proxylinks-container-image .


#
# Building and runnning Proxylinks' container
#
if sudo docker ps -a | grep proxylinks-container; then
    echo "There's already a container with that name"
    printf "Remove it and build a new one with Proxylinks? (y/n): "
    read answer
    if [[ "$answer" =~ [yY] ]]; then
        echo "Removed '$(sudo docker rm proxylinks-container)'"
    fi
fi
#
sudo docker run \
    --name proxylinks-container \
    -it proxylinks-container-image # -it (interactive pseudo-terminal)



