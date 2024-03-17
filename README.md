# ProxyLinks
Bash script to use a server as a proxy.

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

<!-- ABOUT THE PROJECT -->
## About the project
A bash script done for _learning purposes_ that eases the connection to a server as a proxy on Linux systems, avoiding the manual management of system settings. Allows to know the current location based on IP automatically, and aims to help with proxychains too.

<!-- HOW TO START IT -->
## Getting started
### Prerequisites
1. Linux system
2. <a href="https://docs.docker.com/engine/install/">Docker engine</a>
3. Make sure docker buildx comes installed with the docker engine
```sh
docker buildx version # to check the installation

sudo apt update
sudo apt install docker-buildx # if it was not installed (example for ubuntu)
```
3. If bash does not come pre-installed, use your predefined package-manager to install it
```sh
sudo apt install bash # example for ubuntu
```

### Installation and usage
1. Pull the code, and enter _Proxylinks_ folder
2. Enter the docker folder `cd docker` and config the .conf file accordingly
3. Create an image based on the Dockerfile
```sh
chmod +x manage_docker_image.bash
bash manage_docker_image.bash
```
Sidenote: I aim to upload a docker image to dockerhub for an easier setup

## Results


## What I learned until now!
Had fun knowing more about:
* Bash
  * Basic concepts (loops, conditionals, ...)
  * Variable expansion
  * Bash parallel processing
* General
  * Background processes
* Docker
  * runc Daemon and runtimes
  * images
  * buildx
  * registries
  * SSH agents and mounting volumes at runtime








