FROM alpine:3.19

WORKDIR /app/proxylinks/src

# No cache:
#   - improved security by avoiding outdated code being cached
#   - reduced image size 
RUN apk update && \
    apk add --no-cache \
        nano \
        curl \
        iputils \
        jq \
        openssh-client \
        openssh-server \
        xterm \
        dbus-x11
# openssh-server too in case the container is used in proxy chains

COPY src/* ./
RUN find /app/proxylinks/src -type f -name "main.bash" -exec chmod 755 {} +
CMD ["bash", "main.bash"]
