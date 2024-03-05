# C8 Self Managed

All you need to know!

## env vars

```bash
export TEST_DOCKER_USERNAME_CAMUNDA_CLOUD='harbor-username'
export TEST_DOCKER_PASSWORD_CAMUNDA_CLOUD='harbor-password'
export CAMUNDA_LOCAL='path-to-camunda-platform-local'
export CAMUNDA_DOCS='path-to-camunda-platform-docs'
# zeebe
export ZEEBE_ADDRESS='zeebe.local.distro.ultrawombat.com:443'
export ZEEBE_CLIENT_ID='zeebe'
export ZEEBE_CLIENT_SECRET='...'
# get from https://local.distro.ultrawombat.com/auth/realms/camunda-platform/.well-known/openid-configuration
export ZEEBE_AUTHORIZATION_SERVER_URL='https://local.distro.ultrawombat.com/auth/realms/camunda-platform/protocol/openid-connect/token'
export ZEEBE_TOKEN_AUDIENCE='zeebe-api'
```
