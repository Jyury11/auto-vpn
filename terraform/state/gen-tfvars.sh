#! /usr/bin/env bash
set -e

if [ $# -ne 1 ]; then
  echo "usage: make tfvars PROJECT=<project>"
  exit 1
fi

cat <<EOF >terraform.tfvars
project = "$1"
EOF
