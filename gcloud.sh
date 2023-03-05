#!/usr/bin/env bash
set -e

# variable
project_id=$(gcloud config get-value project)
project_number=$(gcloud projects list | grep "$project_id" | awk '{ print $3 }')
zone=us-west1-b

# command
gcloud compute instances create develop \
  --project="$project_id" \
  --zone=$zone \
  --machine-type=e2-micro \
  --network-interface=network-tier=PREMIUM,subnet=default \
  --can-ip-forward \
  --maintenance-policy=MIGRATE \
  --provisioning-model=STANDARD \
  --service-account="$project_number-compute@developer.gserviceaccount.com" \
  --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
  --tags=https-server,vpn,ssh \
  --create-disk="auto-delete=yes,boot=yes,device-name=develop,image=projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20230302,mode=rw,size=30,type=projects/$project_id/zones/$zone/diskTypes/pd-standard" \
  --shielded-secure-boot \
  --shielded-vtpm \
  --shielded-integrity-monitoring \
  --reservation-affinity=any
