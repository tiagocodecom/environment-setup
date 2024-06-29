#!/bin/bash

echo "executing entrypoint..."

# copy the project from the image to the bind volume (at runtime)
if [ -f "/var/www/app/Cargo.toml" ]; then 
    echo "skipping copy process to /var/www/app"
else
    echo "copying the application to /var/ww/app"
    cp -R /tmp/app/* /var/www/app
fi

cd /var/www/app && cargo watch -x run