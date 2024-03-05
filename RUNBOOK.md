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

# generate process instances
# use credentials for zeebe app in identity
zbctl status
zbctl deploy ./bpmn/example.bpmn
zbctl create instance camunda-cloud-quick-start-advanced
zbctl create worker test-worker --handler "echo {\"result\":\"Pong\"}"

# task users
zbctl deploy ./bpmn/example-form.form
zbctl deploy ./bpmn/human-task.bpmn
zbctl create instance human-task

# process instances
zbctl deploy ./bpmn/start-every-30s.bpmn
zbctl create instance start-every-30s

# decision instances
zbctl deploy ./bpmn/which-coin.dmn
zbctl deploy ./bpmn/which-coin.bpmn
zbctl create instance which-coin
zbctl create instance which-coin --variables "{\"coin\": \"btc\", \"rage\": \"high\"}"

# check logs
k logs -f --tail=10 deployments/camunda-platform-console | jq -r '[.level, .timestamp, .message] | join(" | ")'

# break console by configuring a wrong keycloak url
kubectl set env deployment/camunda-platform-console KEYCLOAK_INTERNAL_BASE_URL=http://wrong.url.local
kubectl set env deployment/camunda-platform-console KEYCLOAK_INTERNAL_BASE_URL=http://camunda-platform-keycloak:80/auth
```
