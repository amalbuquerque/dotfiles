FROM rust:1.19.0

WORKDIR /var/code/alacritty

RUN apt-get update && apt-get install cmake libfreetype6-dev libfontconfig1-dev xclip -y
RUN rustup override set stable && rustup update stable

