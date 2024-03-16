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
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#results">Results</a></li>
    <li><a href="#what-i-learned">Results</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About the project
A bash script done for learning purposes that eases the connection to a server as a proxy on Linux systems, avoiding the manual management of system settings. Allows to know the current location based on IP automatically, and aims to help with proxychains too.

With it I've learned more about:
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

<!-- HOW TO START IT -->
## Getting started
### Prerequisites
1. Linux system
2. <a href="https://docs.docker.com/engine/install/">Docker engine</a>
3. Make sure docker buildx comes installed with the docker engine
`docker buildx version` 
`sudo apt install docker-buildx # example for ubuntu`
3. Bash
If bash does not come pre-installed, use your predefined package-manager to install it
```sh
sudo apt update
sudo apt install bash # example for ubuntu
```

### Installation
1. Pull the code and enter the folder
2. `chmod +x install.bash`
3. `bash install.bash`

## Usage
`chmod +x main.bash`

## Results
### Starting image
![Starting image](https://raw.githubusercontent.com/axelcarapinha/Assembly-Character-Identifier/main/images/original.png)










