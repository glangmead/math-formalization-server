# UPDATE for new version
FROM ubuntu:18.04

# stuff to run as root
RUN apt-get upgrade && apt-get update
RUN apt-get install -y sudo curl haskell-platform python3 python3-pip python3-venv wget less vim emacs git

# from here on down we'll be user "math"
RUN useradd -ms /bin/bash math
USER math
WORKDIR /home/math

# Lean: elan and mathlibtools
#   adapted from https://raw.githubusercontent.com/leanprover-community/mathlib-tools/master/scripts/install_debian.sh
#   can't be run as-is because it needs to update your PATH as it runs and that can't happen in this context
RUN python3 -m pip install pipx
# add ~/.local/bin to the path for future interactive use
RUN echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc
# add ~/.local/bin to the path for docker to use
ENV PATH="${PATH}:/home/math/.local/bin"
RUN wget https://raw.githubusercontent.com/Kha/elan/master/elan-init.sh && bash elan-init.sh -y && rm elan-init.sh
RUN pipx install mathlibtools
RUN echo "export PATH=$PATH:$HOME/.elan/bin" >> ~/.bashrc

# Agda
RUN cabal update
RUN cabal install Agda
RUN echo "export PATH=$PATH:$HOME/.cabal/bin" >> ~/.bashrc

# make "math" user a sudoer...
USER root
RUN adduser math sudo
# ... that doesn't require a password
RUN echo "math ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER math
RUN curl -fsSL https://code-server.dev/install.sh | sh

# run the code-server, and the user can connect to 8080 and run further commands from the vscode terminal
CMD code-server --auth none --host 0.0.0.0
