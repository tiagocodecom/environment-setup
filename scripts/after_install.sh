#!/bin/bash

set -euo pipefail

echo ""
echo "[ENV-TIAGOCODE.COM] hook: AfterInstall"
echo ""

cd /home/ec2-user/env-tiagocode.com

cp .env.example .env

docker-compose up -d --build traefik nginx backoffice website redis