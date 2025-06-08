#!/bin/bash

set -euo pipefail

echo "-----------------------------------------------------"
echo "[ENV-TIAGOCODE.COM] hook: ApplicationStop"
echo "-----------------------------------------------------"

cd /home/ec2-user/env-tiagocode.com

docker-compose down
