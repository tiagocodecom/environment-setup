#!/bin/bash

set -euo pipefail

echo "-----------------------------------------------------"
echo "[ENV-TIAGOCODE.COM] hook: ApplicationStart"
echo "-----------------------------------------------------"

cd /home/ec2-user/env-tiagocode.com

docker-compose \
  -f compose.yml \
  -f compose.production.yml \
  up -d --build --remove-orphans traefik nginx backoffice website redis
