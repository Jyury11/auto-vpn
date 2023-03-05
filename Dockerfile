FROM ubuntu:22.04

RUN apt-get update -y
RUN echo "deb http://security.ubuntu.com/ubuntu focal-security main" | tee /etc/apt/sources.list.d/focal-security.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends libssl1.1 && \
  rm /etc/apt/sources.list.d/focal-security.list

RUN apt-get install -y --no-install-recommends gpg gpg-agent
RUN apt-get install -y --no-install-recommends software-properties-common && \
  apt-add-repository ppa:paskal-07/softethervpn
RUN  apt-get update -y && \
  apt-get upgrade

RUN apt-get install -y --no-install-recommends softether-vpnserver \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*
