#!/bin/bash

set -e

# Vault configuration
VAULT_ADDR="http://127.0.0.1:8200"
SECRET_PATH="kv/project2"
ENV_FILE="./code/.env"

export VAULT_ADDR

echo "Retrieving secrets from Vault..."

# Check VAULT_TOKEN
if [ -z "$VAULT_TOKEN" ]; then
    echo "ERROR: VAULT_TOKEN is not set."
    exit 1
fi

# Check Vault availability
if ! vault status >/dev/null 2>&1; then
    echo "ERROR: Vault is not available or is sealed."
    exit 1
fi

# Retrieve secrets from Vault
SECRETS=$(vault kv get -format=json "$SECRET_PATH")

echo "Saving secrets to $ENV_FILE..."

# Create .env file
echo "$SECRETS" | jq -r '.data.data | to_entries[] | .key + "=" + .value' > "$ENV_FILE"

# Protect .env
chmod 600 "$ENV_FILE"

echo "Secrets successfully written to $ENV_FILE"
echo "Done."
