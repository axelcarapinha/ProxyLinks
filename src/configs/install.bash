#
# Creating and running the container
#
sudo docker build -t proxylinks-container-image .
sudo docker run \ 
    --name proxylinks-container \ 
    -it proxylinks-container-image # -it (interactive pseudo-terminal)



