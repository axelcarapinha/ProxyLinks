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
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#results">Results</a></li>
    <li><a href="#what-i-learned">What I learned!</a></li>
  </ol>
</details>

## About the project
A bash script done for _learning purposes_ with an ssh (encrypted) proxy connection as the main goal.  
Allows to know the current location based on IP in a cyclic way and ease the manipulation of settings for Linux systems, mainly.

## Getting started 
- Linux based distro
- Python3 3.10.12 (for Firefox settings change)
- <a href="https://docs.docker.com/engine/install/">Docker engine</a> (for the containerized SSH)
- Bash 
  
1.
```zsh
git clone git@github.com:axelcarapinha/ProxyLinks.git
cd PROXYLINKS
```
2. <a href="https://github.com/mozilla/geckodriver/releases">Geckodriver</a>'s latest release
3. Place the download file on the _browser\_settings_ folder
4. Let the magic happen! 
```zsh
chmod +x install.sh
sudo apt update && sudo apt upgrade
bash install.sh
```

### Proxy server
```zsh
make
```
### Containerized SSH to custom server
1. Make sure docker buildx comes installed with the docker engine
```sh
docker buildx version # to check the installation
sudo apt update
sudo apt install docker-buildx # if it was not installed (example for apt)
```
2. INTERACTIVE_SSH=1 (on proxylinks/configs/config.conf)
3. Customize _docker\_init.bash_ and _Dockerfile_ ("Use the source, Luke!")
4. `make container`

## Results
⚠️ Not recorded yet

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
* Browsers
  * Drivers
  * Rendering Engine and Layout engine
  * PAC (Proxy Auto-Configuration)
* Server maintenance (starting)
  * Activity and login attempts logs








