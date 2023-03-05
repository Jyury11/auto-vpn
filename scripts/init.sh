#! /usr/bin/env bash
set -e

DIR=$(cd "$(dirname "$0")" && pwd)

cd "$DIR/../ansible/cloud" && make setup
