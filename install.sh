#!/bin/bash
# Prepare the script environment

# Because of a problem running Firefox from a container
# 0.34.0 (2024-01-03, c44f0d09630a) 
source proxylinks/src/utils_general 

# Preparing the venv
python3 -m venv . # I wanted in this folder
source ./bin/activate
./bin/python3 --version # for the venv version
echo "$VIRTUAL_ENV"

# Installing dependencies
pip3 install selenium
# sudo mv geckodriver /usr/local/bin
# sudo mv geckodriver /snap/bin/geckodriver

# If geckodriver is REMOVED from the /usr/local/bin folder
ln -s /usr/local/bin geckodriver

export TMPDIR=$HOME/tmp geckodriver

chmod +x geckdriver

# If not working
export PATH=$PATH:/usr/local/bin/geckodriver


# Preparing to run the script
chmod u+x Docker/docker_init.bash src/main.bash
chmod u+rw proxylinks.log




