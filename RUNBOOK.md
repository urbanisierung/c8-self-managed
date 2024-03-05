# runbook

```bash
# install SNAPSHOT
# ./scripts
./c8 install

# open docs pr
./c8 docs

# check http://localhost:8080/

# check https://local.distro.ultrawombat.com

# enable telemetry
kubectl set env deployment/camunda-platform-console CAMUNDA_CONSOLE_CUSTOMERID=urbanisierung-in-da-house CAMUNDA_CONSOLE_INSTALLATIONID=lenovo-diypunk CAMUNDA_CONSOLE_TELEMETRY_ENABLED="true"

# check logs
k logs -f --tail=10 deployments/camunda-platform-console | jq -r '[.level, .timestamp, .message] | join(" | ")'

# break console by configuring a wrong keycloak url
kubectl set env deployment/camunda-platform-console KEYCLOAK_INTERNAL_BASE_URL=http://wrong.url.local
kubectl set env deployment/camunda-platform-console KEYCLOAK_INTERNAL_BASE_URL=http://camunda-platform-keycloak:80/auth
```
