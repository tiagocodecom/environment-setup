#!/bin/bash

set -euo pipefail

echo "-----------------------------------------------------"
echo "[ENV-TIAGOCODE.COM] hook: ApplicationStart"
echo "-----------------------------------------------------"

cd /home/ec2-user/env-tiagocode.com

docker-compose up -d --build traefik nginx backoffice website redis
