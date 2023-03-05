#! /usr/bin/env bash
set -e

if [ $# -ne 3 ]; then
  echo "usage: make var USER=<username> PASSWORD=<password> SECRET=<secret>"
  exit 1
fi

DIR=$(cd "$(dirname "$0")" && pwd)
ROOT_DIR=$(cd "$DIR/../../../" && pwd)

cat <<EOF >playbook/accounts.yml
---
accounts:
  - name: $1
    password: $2
    vpnsecret: $3
EOF

cat <<EOF >playbook/node/roles/docker/files/docker-compose.yml
---
version: "3"
services:
  softether_server:
    image: siomiz/softethervpn
    cap_add:
      - NET_ADMIN
    ports:
      - 500:500/udp
      - 4500:4500/udp
      - 1701:1701/tcp
      - 5555:5555/tcp
    container_name: softether-server
    environment:
      - USERNAME=$1
      - PASSWORD=$2
      - PSK=$3
      - VPNCMD_HUB=SecureNatDisable
EOF

cat <<EOF >$ROOT_DIR/local/vpnbridge/docker-compose.yml
version: "3"
services:
  softether_bridge:
    image: sammrai/softether-bridge:latest
    container_name: softether-bridge
    environment:
      - USERNAME=$1
      - PASSWORD=$2
      - PSK=$3
      - VPN_SERVER=host.docker.internal:5555
    networks:
      app_net:
        ipv4_address: 172.30.0.2
  nginx:
    image: nginx:latest
    ports:
      - 8080:80
    networks:
      app_net:
        ipv4_address: 172.30.0.3
networks:
  app_net:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 172.30.0.0/24
EOF
