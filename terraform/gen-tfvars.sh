#! /usr/bin/env bash
set -e

if [ $# -ne 4 ]; then
  echo "usage: make tfvars PROJECT=<project> PROJECT_NAME=<project name> PROJECT_NUMBER=<project number> ACCOUNT=<account>"
  exit 1
fi

cat <<EOF >terraform.tfvars
project        = "$1"
project_name   = "$2"
project_number = "$3"
account        = "$4"
EOF

cat <<EOF >terraform.tf
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.22.0"
    }
  }

  backend "gcs" {
    bucket  = "$1-terraform-state"
  }
}

EOF
