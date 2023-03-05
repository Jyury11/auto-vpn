FROM ubuntu:22.04

RUN apt-get update -y && \
  apt-get -y --no-install-recommends install \
  sshpass \
  openssh-server \
  jq

ENV LC_ALL="ja_JP.UTF-8"
ENV LC_CTYPE="ja_JP.UTF-8"

RUN mkdir -p /tmp/modules
COPY requirements.txt /tmp/modules
WORKDIR /tmp/modules

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install -r requirements.txt

WORKDIR /workspace
