# Install C8

# Notes

```bash
# what's running on port :80
sudo lsof -i :80

sudo service apache2 stop
```

## Create local kind Cluster

```bash
# create local cluster
kind create cluster --config clusters/kind/kind-cluster-config.yaml --name camunda-platform-local

# switch to cluster
kubectl ctx kind-camunda-platform-local

# delete cluster (just fyi)
kind delete cluster --name camunda-platform-local

# Ingress controller
kubectl kustomize --enable-helm modules/ingress-nginx | kubectl apply -f -

# change namespace
kubectl ns ingress-nginx

# rollout status
kubectl rollout status deployment/ingress-nginx-controller

# check pods
kubectl get pods

# logs of controller
kubectl logs deployment/ingress-nginx-controller

# create camunda-platform namespace
kubectl create namespace camunda-platform

# switch to namespace
kubectl ns camunda-platform

# create tls certificate
kubectl apply -n camunda-platform -f modules/camunda-platform/secret.yaml
```

## Install C8

```bash
# both commands must output 127.0.0.1
dig +short local.distro.ultrawombat.com
dig +short zeebe.local.distro.ultrawombat.com

# set secrets
make secret.webmodeler.create
# or:
kubectl create secret docker-registry registry-camunda-cloud \
			--namespace camunda-platform \
			--docker-server "registry.camunda.cloud" \
			--docker-username "$${TEST_DOCKER_USERNAME_CAMUNDA_CLOUD}" \
			--docker-password "$${TEST_DOCKER_PASSWORD_CAMUNDA_CLOUD}"

# install c8 with helm
# check https://github.com/camunda/camunda-platform-helm/releases
helm template camunda-platform camunda/camunda-platform --version 9.2.0 --values c8-helm-settings.yaml --skip-tests | kubectl apply -n camunda-platform -f -

# check pods and ingress, and decribe the ingress
kubectl get pods
kubectl get ingress
kubectl describe ingress camunda-platform

# verify zeebe
zbctl status --address zeebe.local.distro.ultrawombat.com:443
zbctl deploy example.bpmn --address zeebe.local.distro.ultrawombat.com:443
zbctl create instance camunda-cloud-quick-start-advanced --address zeebe.local.distro.ultrawombat.com:443
zbctl create worker test-worker --handler "echo {\"result\":\"Pong\"}" --address zeebe.local.distro.ultrawombat.com:443

# update nginx config
k edit ingress camunda-platform
# update redirect url for console
# update jwt

# cleanup everything
make clean
helm uninstall camunda-platform -n camunda-platform
kubectl delete pvc -l app.kubernetes.io/instance=camunda-platform -n camunda-platform
```

## useful commands

```bash
# edit console deployment
k edit deployments.apps camunda-platform-console

# update envvars
kubectl set env deployment/camunda-platform-console CAMUNDA_CONSOLE_CUSTOMERID=urbanisierung-in-da-house CAMUNDA_CONSOLE_INSTALLATIONID=lenovo-diypunk CAMUNDA_CONSOLE_TELEMETRY_ENABLED="true"

# show error handling in console
kubectl set env deployment/camunda-platform-console KEYCLOAK_INTERNAL_BASE_URL=http://wrong.url.local
kubectl set env deployment/camunda-platform-console KEYCLOAK_INTERNAL_BASE_URL=http://camunda-platform-keycloak:80/auth

# list all envvars
kubectl set env deployment/camunda-platform-console --list

# follow console logs
k logs -f --tail=10 deployments/camunda-platform-console

# prettyfied logs
k logs -f --tail=10 deployments/camunda-platform-console | jq -r '[.level, .timestamp, .message] | join(" | ")'
```
