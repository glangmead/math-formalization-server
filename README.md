# math-formalization-server
Docker app to experiment with formalization of mathematics in the browser

## Installation

### Docker
You will install Docker then load the image I have made, then access Visual Studio code from your browser, where you can play with both Lean and Agda.

1. Install Docker: https://docs.docker.com/get-docker/
2. Visit the Docker settings to allocate some RAM (I use 10GB) and some disk space (I use 60GB).

The way Docker works, you obtian the image then run it. When it's running it's called a container. 

### Option 1: build image locally and run
To build and run the server image locally, clone this repo, cd into it and run 
```
docker build -t math-formalization-server .
docker run -it -p 8080:8080 -v "$HOME:/home/math/homedir" math-formalization-server
```
The first command will take 30-60 minutes, mainly because it takes a long tiem to install Agda! The `-v` part will mount your actual machine's home directory inside the docker container. The container has a user called `math` which is "you", and so `~/homedir` will have your real machine's data inside. Feel free to mount some other path and call it something else inside `/home/math`! You can have multiple `-v` arguments to mount multiple directories if you like.

### Option 2: pull from docker hub
To download the image from docker hub, make an account at https://hub.docker.com and use `docker login` then do
```
docker pull glangmead/math
docker run -it -p 8080:8080 -v "$HOME:/home/math/homedir" glangmead/math
```

## Usage
This is very experimental stuff! After the container is running, you can open http://localhost:8080 to see a version of Visual Studio Code running in the browser. This comes from https://github.com/cdr/code-server. 

You'll need to install the Lean plugin and Agda plugin yourself. The Agda plugin is not part of code-server's self-maintained Extensions directory as of this writing, though I have requested it here: https://github.com/cdr/code-server/issues/2177. The workaround is 

1. Go to https://marketplace.visualstudio.com/items?itemName=banacorn.agda-mode and download the extension (it ends in .vsix)
2. Put the .vsix in a directory you have mounted in the docker container.
3. In code-server in your browser, go to Extensions (the bottom button in the left pane), click the "..." dots icon then "Install from VSIX..." and browse to the file.

The Lean plugin is available in the Extensions directory so just type "lean" in search.

You can bring up an interactive terminal in code-server! Click the very top-left icon (three horizontal lines), then Terminal > New Terminal.
