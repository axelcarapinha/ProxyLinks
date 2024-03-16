FROM ubuntu:latest

# Allows docker to build without interruptions
# (that could appear due to interactive limitations of it)
ENV DEBIAN_FRONTEND=noninteractive

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
    install xterm

#TODO pull from this script, to be able to work with it directly
#TODO automate the build of an alias

RUN systemctl enable ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
