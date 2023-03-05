FROM ubuntu:22.04

RUN apt-get update -y && apt-get -y --no-install-recommends install sshpass python3-pip openssh-server
RUN pip3 install ansible paramiko
RUN pip3 install -U ansible

WORKDIR /workspace
