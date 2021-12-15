FROM rust:slim-buster

WORKDIR /root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
            vim 

RUN cargo install mdbook
