FROM ubuntu:latest

# Allows docker to build without interruptions
# (that could appear due to interactive limitations of it)
ENV DEBIAN_FRONTEND=noninteractive

# Update the package lists
RUN apt-get update

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    apt-utils \
    curl \
    iputils-ping \
    jq \
    gsettings-desktop-schemas \
    openssh-client \
    openssh-server \
    xterm

RUN systemctl enable ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*



WORKDIR /app
COPY src /app/proxylinks/src

# Give permissions to all .bash files and start the script execution
RUN cd /app/proxylinks/src && \
    find -type f -name "*.bash" -exec chmod 755 {} +


# Startin command
# CMD ["cd proxylinks/src/ && bash main.bash"]
