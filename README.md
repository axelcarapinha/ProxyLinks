# ProxyLinks
Bash script to use a server as a proxy or ssh from a container safely.

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#proxy-server">Proxy server</a></li>
        <li><a href="#containerized-ssh-to-server">Containerized SSH to server</a></li>
      </ul>
    </li>
    <li><a href="#folder-structure">Folder Structure</a></li>
    <li><a href="#results">Results</a></li>
    <li><a href="#what-i-learned-until-now">What I learned until now!</a></li>
  </ol>
</details>

## About the project
A bash script done for _learning purposes_ with an ssh (encrypted) proxy connection as the main goal.  
Allows to know the current location based on IP in a cyclic way and ease the manipulation of settings for Linux systems, mainly.

## Getting started (6 steps OR 1 alias)
- Linux based distro
- Python3 3.10.12 (for Firefox settings change)
- <a href="https://docs.docker.com/engine/install/">Docker engine</a> (for the containerized SSH)
- Bash 
- Firefox, but NOT the snap package (<a href="https://github.com/mozilla/geckodriver/releases">0.34.0 "Startup hang with Firefox running in a container (e.g. snap, flatpak):"</a>)
  
1. Get the script
```zsh
git clone https://github.com/axelcarapinha/ProxyLinks.git && cd ProxyLinks
```
2. <a href="https://github.com/mozilla/geckodriver/releases">Geckodriver</a>'s latest release
3. Place the download file on the _browser\_settings_ folder
4. Prepare the environment (use the opened window to browse with the proxy)
```zsh
chmod +x prepare.bash
sudo apt update && sudo apt upgrade
bash prepare.bash
```
5. `chmod 600 private_key.pem # ensure adequate privileges are granted` 
6. Place the path for the private key on the config file (command _realpath_ is recommended to know it)
7. (optional) For an easier daily use
```sh
vim ~/.bashrc # or use other editor

# Place this alias where you prefer
alias pl="cd /path/to/proxylinks/folder && bash prepare.bash && make"
```

### Proxy server
```zsh
make
```
### Containerized SSH to server
1. Make sure docker buildx comes installed with the docker engine
```sh
docker buildx version # to check the installation
sudo apt update
sudo apt install docker-buildx # if it was not installed (example for apt)
```
2. INTERACTIVE_SSH=1 (on proxylinks/configs/config.conf)
3. Customize _docker\_init.bash_ and _Dockerfile_ ("Use the source, Luke!")
4. `make container`

## Folder Structure
```sh
.
├── browser_settings
│   ├── browser.py
│   └── requirements.txt
├── install.sh
├── Makefile
├── proxylinks
│   ├── configs
│   │   └── config.conf
│   ├── Dockerfile
│   ├── docker_init.bash
│   └── src
│       ├── ascii_art.txt
│       ├── available_cmds.txt
│       ├── interface
│       ├── main.bash
│       ├── utils_general
│       └── utils_proxy
└── README.md
```

## Results
Recorded, only need to edit the video.

## What I learned until now!
Had fun knowing more about:
* Bash
  * Basic concepts (loops, conditionals, ...)
  * Variable expansion
  * Bash parallel processing
  * Some secure coding practices
* General
  * Background processes
  * Snap packages
  * Direct and Transitive dependencies
  * Python virtual envs
* Docker
  * runc Daemon and runtimes
  * images
  * buildx
  * registries
  * SSH agents and mounting volumes at runtime
  * layers
  * privilege good practices
  * build context
  * Relation between ENTRYPOINT, CMD and Docker run
* Web scrapping
  * Selenium
  * Regulations
  * Browsing profiles and configuration pages
* Browsers
  * Drivers
  * Rendering Engine and Layout engine
  * PAC (Proxy Auto-Configuration)
* Server maintenance (starting)
  * Activity and login attempts logs








