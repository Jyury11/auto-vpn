#! /usr/bin/env bash
set -e

DIR=$(cd "$(dirname "$0")" && pwd)
ROOT_DIR=$(cd "$DIR/../" && pwd)
ACCOUNT=$(gcloud config get-value account | tr '@.' '_')

IP=$(gcloud compute instances list | grep vpn-server | awk '{ print $5 }')

yq -y ".services.softether_bridge.environment[3]|=\"VPN_SERVER=$IP:5555\"" "$ROOT_DIR/local/vpnbridge/docker-compose.yml" > "$ROOT_DIR/local/vpnbridge/docker-compose.yml.tmp"
mv "$ROOT_DIR/local/vpnbridge/docker-compose.yml.tmp" "$ROOT_DIR/local/vpnbridge/docker-compose.yml"

cat <<EOF >$ROOT_DIR/ansible/cloud/hosts/hosts.yaml
all:
  hosts:
    node1:
      ansible_host: $IP
      ansible_port: 22
      ansible_user: $ACCOUNT
      ansible_ssh_private_key_file: $ROOT_DIR/ansible/cloud/.ssh/id_rsa
EOF

cat <<EOF >$ROOT_DIR/ansible/cloud/playbook/node/roles/docker/vars/main.yml
---
user: $ACCOUNT
EOF


cat <<EOF >$ROOT_DIR/ansible/cloud/.ssh/config
Host vpnserver
    HostName $IP
    User $ACCOUNT
    Port 22
    IdentityFile $ROOT_DIR/ansible/cloud/.ssh/id_rsa
EOF
