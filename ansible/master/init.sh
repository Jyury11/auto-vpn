#!/usr/bin/env bash
set -e

ansible-playbook playbook/local.yml

cat /home/node1/.ssh/id_node1_rsa.pub
