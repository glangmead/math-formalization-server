# UPDATE for new version
FROM codercom/code-server:3.5.0

RUN sudo apt-get upgrade && sudo apt-get update
RUN sudo apt-get install -y haskell-platform python3 wget
# Lean
RUN wget -q https://raw.githubusercontent.com/leanprover-community/mathlib-tools/master/scripts/install_debian.sh && bash install_debian.sh
# haskell for Agda, python and wget for Lean
RUN cabal update
# Agda
RUN cabal install Agda
CMD /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:$PORT .
