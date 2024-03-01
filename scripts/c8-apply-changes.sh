#!/bin/bash

# setup

CAMUNDA_LOCAL=$1
CONFIG=$2

log() {
  printf "\n\n>>> $1\n"
}

log "Applying changes"
helm template camunda-platform camunda/camunda-platform --values $CONFIG --skip-tests | kubectl apply -n camunda-platform -f -

# wait for c8
log "Wait for C8"
kubectl get pods
kubectl get ingress
