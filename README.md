# ProxyLinks
⚠️ In development, some features may not work.
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
A bash script done for _learning purposes_ with an ssh (encrypted) proxy connection as the main goal.  
Allows to know the current location based on IP in a cyclic way and ease the manipulation of settings for Linux systems, mainly.

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
sudo apt install bash # for ubuntu systems
```

### Installation and usage
⚠️ Because of implementation changes, this section will remain empty until a working version.
Sidenote: I aim to upload a docker image to dockerhub for an easier setup

## Results


## What I learned until now!
Had fun knowing more about:
* Bash
  * Basic concepts (loops, conditionals, ...)
  * Variable expansion
  * Bash parallel processing
  * Some secure coding practices
* General
  * Background processes
* Docker
  * runc Daemon and runtimes
  * images
  * buildx
  * registries
  * SSH agents and mounting volumes at runtime
  * layers








