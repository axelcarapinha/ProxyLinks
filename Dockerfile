FROM ubuntu:latest

# Allows docker to build without interruptions
# (that could appear due to interactive limitations of it)
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app/proxylinks/src

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    apt-utils \
    nano \
    curl \
    iputils-ping \
    jq \
    gsettings-desktop-schemas \
    openssh-client \
    openssh-server \
    xterm

RUN apt-get install dbus-x11 && \
    eval $(dbus-launch --sh-syntax)

RUN systemctl enable ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY src ./

# Give permissions to all .bash files and start the script execution
RUN cd /app/proxylinks/src && \
    find -type f -name "*.bash" -exec chmod 755 {} +

CMD ["bash", "main.bash"]

# COPY docker_init.bash home/asusftr/Desktop/here/ProxyLinks/docker_init.bash
# RUN chmod +x home/asusftr/Desktop/here/ProxyLinks/docker_init.bash
# CMD ["home/asusftr/Desktop/here/ProxyLinks/docker_init.bash"]