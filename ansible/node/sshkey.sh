#!/usr/bin/env bash
set -e

vim ~/.ssh/authorized_keys
chmod 0700 ~/.ssh
chmod 0600 ~/.ssh/authorized_keys

/usr/sbin/sshd -D &
