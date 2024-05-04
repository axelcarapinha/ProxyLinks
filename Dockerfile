FROM alpine:3.19

# No cache:
    #   - improved security by avoiding outdated code being cached
    #   - reduced image size 
RUN apk update && \
    apk add --no-cache \
    bash \
    coreutils \
    curl \
    dbus-x11 \
    iputils \
    jq \
    nano \
    openssh-client \
    openssh-server \
    xterm 
# openssh-server (possible use for P2P)
# coreutils -> for the tee command
# apk does already deal with removing the cache 

# For a possible use for P2P
EXPOSE 22 

# Copy source code
WORKDIR /app/proxylinks/
RUN mkdir -p src configs
COPY src/* /app/proxylinks/src/
COPY configs/* /app/proxylinks/configs/
#TODO NOT baking the configs in the image
#TODO consider multi-stage build

ENTRYPOINT ["sh", "-c", "/app/proxylinks/src/main.bash --start"]
