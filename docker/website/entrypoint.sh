#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

src_dir="/usr/src/app"

if [[ ! -f "${APP_ROOT}/Cargo.toml" ]]; then
    rm -rf "${APP_ROOT}/*"
    echo "${APP_NAME} not found in ${APP_ROOT} - copying now..."
    rsync -a "${src_dir}/" "${APP_ROOT}/"
    echo "Complete! ${APP_NAME} has been successfully copied to ${APP_ROOT}"
else
    echo "${APP_NAME} already exists in ${APP_ROOT} - skipping copy..."
fi

cd /var/www/app || exit


git config --global --add safe.directory /var/www/app
echo "Complete! git has been successfully configured"

trunk serve --port 3000 --address 0.0.0.0