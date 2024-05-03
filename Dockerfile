FROM alpine:3.19

# No cache:
    #   - improved security by avoiding outdated code being cached
    #   - reduced image size 
RUN apk update && \
    apk add --no-cache \
    bash \
    nano \
    curl \
    iputils \
    jq \
    openssh-client \
    openssh-server \
    xterm \
    dbus-x11 \
    coreutils 
# openssh-server (possible use for P2P)
# coreutils -> for the tee command

# Establish appropriate permissions


# Copy source code
WORKDIR /app/proxylinks/
RUN mkdir -p src configs
COPY src/* ./src/
COPY configs/* ./configs/
#TODO NOT baking the configs in the image

# For a possible use for P2P
EXPOSE 22 

# In case the dev uses permissions in this file
# RUN chmod +x main.bash

# ENTRYPOINT ["sh", "-c", "/app/proxylinks/src/main.bash --start"]
