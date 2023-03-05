#!/usr/bin/env bash

# install packages
sudo apt-get update -y
sudo apt-get -y --no-install-recommends install sshpass python3-pip openssh-server

# install ansible
pip3 install ansible paramiko
pip3 install -U ansible
