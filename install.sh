#!/bin/bash
# Prepare the script's environment

source proxylinks/configs/config.conf

# Prepare 'Geckodriver'
cd browser_settings
if [[ -z $(which geckodriver) ]]; then
    tar xvfz geckodriver*.tar.gz
    chmod +x geckodriver
    sudo mv geckodriver /usr/local/bin
fi
# ln -s /usr/local/bin geckodriver
export PATH=$PATH:/usr/local/bin/geckodriver

# Python virtual environment
if [[ "$IS_VENV" -eq 1 ]]; then
    echo "Using a python virtual environment for python dependencies..."
    python3 -m venv $PWD 
    source ./bin/activate
    # ./bin/python3 --version 

    if [[ -z "$VIRTUAL_ENV" ]]; then
        log_error "Error setting the virtual environment."
        return -1;
    fi
fi

pip3 install -r requirements.txt
python3 browser.py # Prepare Firefox proxy settings

# FINAL part
cd ..
chmod u+x proxylinks/docker_init.bash proxylinks/src/main.bash