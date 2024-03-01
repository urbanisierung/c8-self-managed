#!/bin/bash

# setup

CAMUNDA_LOCAL=$1

log() {
  printf "\n\n>>> $1\n"
}

# unreleased helm charts
log "Cleaning up C8"
make clean -C $CAMUNDA_LOCAL
