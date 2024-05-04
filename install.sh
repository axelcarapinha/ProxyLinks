#!/bin/bash
# Prepare the script's environment

source proxylinks/configs/config.conf

# Prepare 'Geckodriver'
cd browser_settings
if [[ -z $(which geckodriver) ]]; then
    wget -O geckodriver-v0.34.0-linux64.tar.gz https://github.com/mozilla/geckodriver/releases/
    tar xvfz geckodriver-v0.34.0-linux64.tar.gz
    rm geckodriver-v0.34.0-linux64.tar.gz
    chmod +x geckodriver
    sudo mv geckodriver /usr/local/bin
    export PATH=$PATH:/usr/local/bin/geckodriver
    # ln -s /usr/local/bin geckodriver
fi

# Python virtual environment
if [[ "$IS_VENV" -eq 1 ]]; then
    echo "Using a python virtual environment for python dependencies..."
    python3 -m venv . 
    source ./bin/activate
    # ./bin/python3 --version 

    if [[ -z "$VIRTUAL_ENV" ]]; then
        log_error "Error setting the virtual environment."
        return -1;
    fi
fi
pip3 install -r requirements.txt

# Prepare Firefox settings
cd browser_settings
python3 browser.py
cd ..

# FINAL part
chmod u+x proxylinks/docker_init.bash proxylinks/src/main.bash




