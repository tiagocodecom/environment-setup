#!/bin/bash

echo "[INFO] executing entrypoint..."

cd /var/www/app || exit

if [ -f "Cargo.toml" ]; then 
    echo "[INFO] skip clonning process to /var/www/app"
else
    echo "[INFO] clone the application to /var/ww/app"
    git clone https://github.com/tiagocodecom/back-office.git . 
fi

cargo watch -x run