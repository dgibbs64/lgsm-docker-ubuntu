#
# CSGO Dockerfile
#
# https://github.com/dgibbs/lgsm-docker
#

# Pull the base image
FROM ubuntu:14.04
MAINTAINER Daniel Gibbs <me@Danielgibbs.co.uk>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN sudo dpkg --add-architecture i386
RUN sudo apt-get update
RUN sudo apt-get install -y tmux mailutils postfix lib32gcc1 libstdc++6 libstdc++6:i386 git wget vim

# Cleanup
RUN sudo apt-get clean
RUN rm -fr /var/lib/apt/lists/*
RUN  rm -fr /tmp/*

# Create user to run as
RUN \
  groupadd -r lgsm && \
  useradd -rm -g lgsm lgsm && \
  echo "lgsm ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Volume
RUN chown -R lgsm:lgsm /home/lgsm

# Define working directory
WORKDIR /home/lgsm

USER lgsm

# Install CSGO Server
RUN git clone https://github.com/dgibbs64/linuxgsm.git

# Expose port
# - 27015: Port to serve on
EXPOSE 27015/tcp
EXPOSE 27015/udp
EXPOSE 27020/tcp
EXPOSE 27020/udp