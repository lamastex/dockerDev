FROM haskell:buster

WORKDIR /root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
            vim && \
    curl -sSL https://get.haskellstack.org/ | sh -s - -f 

RUN mkdir -p /root/tilowiklund && \
    cd /root/tilowiklund && \
    git clone https://gitlab.com/tilowiklund/pinot.git && \ 
    cd pinot && \
    stack init && stack setup --install-ghc && stack build

ENV PINOT_DIR="/root/tilowiklund/pinot"
