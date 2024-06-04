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
    <li><a href="#video-guide-and-results">Video guide and Results</a></li>
    <li><a href="#what-i-learned-until-now">What I learned until now!</a></li>
  </ol>
</details>

## About the project
A bash script to use your own server as a proxy, with virtualized dependencies for an automated and privacy-focused Firefox browsing.
Can also be used to automate SSH from a Docker container safely, without exposing SSH private keys.

## Getting started (6 steps OR 1 alias)
### Pre-requisites
- Linux based distro (tested on Ubuntu)
- Gnome desktop environment (the proxy settings can only be changed by using _gsettings_, for now)
- Firefox, but <a href="https://github.com/mozilla/geckodriver/releases">NOT the snap package</a> because of <a href="https://github.com/mozilla/geckodriver/releases">this</a>
- Others:
```sh
sudo apt install python3 python3-venv
sudo apt install make
```
- <a href="https://docs.docker.com/engine/install/">Docker engine</a> (for the containerized SSH)
- Capacity to SSH from the host to the server

### Installation
1. Get the script:
```zsh
git clone https://github.com/axelcarapinha/ProxyLinks.git && cd ProxyLinks
```
2. <a href="https://github.com/mozilla/geckodriver/releases">Geckodriver</a>'s latest release
3. Prepare geckodriver's tar for use:
```sh
mv ~/Downloads/geckodriver*.tar.gz browser_settings
```

4. Prepare the environment:
```zsh
chmod +x prepare.bash
sudo apt update && sudo apt upgrade
bash prepare.bash
```
### Configuration 
5. Config absolute path for the private key:
```sh
nano proxylinks/configs/config.conf # to edit the file
# Recommend to use 'realpath' command for it
```

6. (optional) For an easier daily use:
```sh
nano ~/.bashrc # or use other editor

# Place the alias anywhere, BUT there's already a section for that
alias pl="cd /path/to/proxylinks/folder && bash prepare.bash && make"
```

### Use (Proxy server)
```sh
bash prepare.bash # if it was NOT in the step 4
make # Use the opened window to browse with the proxy.
```

### Use (Containerized SSH to server)
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

## Video guide and Results
<a href="https://youtu.be/jHA6hbA2plE">Video guide and results </a>


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
* Server maintenance
  * Activity and login attempts logs
  * Public and private key management
