#!/bin/bash

# setup

CAMUNDA_LOCAL=$1
CONFIG=$2

log() {
  printf "\n\n>>> $1\n"
}

# unreleased helm charts
log "Use unreleased helm charts"
make camunda.unreleased -C $CAMUNDA_LOCAL

# create cluster
log "Create cluster"
kind create cluster --config $CAMUNDA_LOCAL/clusters/kind/kind-cluster-config.yaml --name camunda-platform-local
kubectl ctx kind-camunda-platform-local

# create infra
log "Create infra"
kubectl kustomize --enable-helm $CAMUNDA_LOCAL/modules/ingress-nginx | kubectl apply -f -
kubectl create namespace camunda-platform
kubectl ns camunda-platform
kubectl apply -n camunda-platform -f $CAMUNDA_LOCAL/modules/camunda-platform/secret.yaml
make secret.webmodeler.create -C $CAMUNDA_LOCAL

# install c8
# kubectl kustomize --enable-helm deployments/camunda-platform | kubectl apply -n camunda-platform -f -
# helm template camunda-platform camunda/camunda-platform --version 9.2.0 --values c8-with-console.yaml --skip-tests | kubectl apply -n camunda-platform -f -
log "Install C8"
helm template camunda-platform camunda/camunda-platform --values $CONFIG --skip-tests | kubectl apply -n camunda-platform -f -

# wait for c8
log "Wait for C8"
kubectl get pods
kubectl get ingress
