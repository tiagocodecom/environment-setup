#!/bin/bash

echo "[INFO] executing entrypoint..."

cd /var/www/app || exit

if [ -f "Cargo.toml" ]; then 
    echo "[INFO] skip clonning process to /var/www/app"
else
    echo "[INFO] clone the application to /var/ww/app"
    git clone https://github.com/tiagocodecom/website.git . 
fi

trunk serve --port 3000 --address 0.0.0.0