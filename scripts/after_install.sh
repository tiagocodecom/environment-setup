#!/bin/bash

set -euo pipefail

echo "-----------------------------------------------------"
echo "[ENV-TIAGOCODE.COM] hook: AfterInstall"
echo "-----------------------------------------------------"

cd /home/ec2-user/env-tiagocode.com

if [ -f ".env" ]; then
  echo "[ENV-TIAGOCODE.COM] Removing existing .env file..."
  rm .env
fi

cp .env.example .env

declare -A PARAMS=(
  [COMPOSE_PROJECT_NAME]="/tiagocode/project/name"
  [PROJECT_NAME]="/tiagocode/project/name"
  [PROJECT_ENVIRONMENT]="/tiagocode/project/environment"
  [PROJECT_DOMAIN_NAME]="/tiagocode/project/domain_name"
  [PROJECT_SECOND_LEVEL_DOMAIN]="/tiagocode/project/second_level_domain"
  [BACKOFFICE_HASH_SALT]="/tiagocode/service-drupal/hash_salt"
  [BACKOFFICE_DB_PREFIX]="/tiagocode/service-drupal/database_prefix"
  [BACKOFFICE_DB_HOST]="/tiagocode/database/host"
  [POSTGRES_DB]="/tiagocode/database/name"
  [POSTGRES_USER]="/tiagocode/database/username"
  [POSTGRES_PASSWORD]="/tiagocode/database/password"
  [TRAEFIK_USER_PASSWORD]="/tiagocode/service-traefik/username_password"
  [TRAEFIK_ACME_EMAIL]="/tiagocode/cloudflare/email"
  [TRAEFIK_CF_EMAIL]="/tiagocode/cloudflare/email"
  [TRAEFIK_CF_API_KEY]="/tiagocode/cloudflare/api_key"
  [TRAEFIK_CF_DNS]="/tiagocode/cloudflare/dns"
  [REDIS_PASSWORD]="/tiagocode/service-redis/password"
  [WEBSITE_JSONAPI_API_URL]="/tiagocode/service-frontend/api_url"
  [WEBSITE_JSONAPI_IMAGES_URL]="/tiagocode/service-frontend/images_url"
  [WEBSITE_JSONAPI_USERNAME]="/tiagocode/service-frontend/api_username"
  [WEBSITE_JSONAPI_PASSWORD]="/tiagocode/service-frontend/api_password"
)

for key in "${!PARAMS[@]}"; do
  ssm_param="${PARAMS[$key]}"
  value=$(aws ssm get-parameter --name "$ssm_param" --with-decryption --query "Parameter.Value" --output text)

  sed -i "s|^$key=.*|$key=$value|" ".env"
done

