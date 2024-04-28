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
    dbus-x11
# openssh-server too in case the container is used in proxy chains
    
# Copy the needed code
WORKDIR /app/proxylinks/
RUN mkdir -p src configs
COPY src/* ./src/
COPY configs/* ./configs/

# Enter in the main folder
WORKDIR /app/proxylinks/src

# Enable SSH connections (use other port for improved security)
EXPOSE 22 

RUN chmod +x main.bash
ENTRYPOINT ["sh", "-c", "/app/proxylinks/src/main.bash --start"]
