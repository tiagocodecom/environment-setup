ARG PHP_VERSION=latest
ARG BACK_OFFICE_VERSION=latest
ARG CONTAINER_REGISTRY_URL=ghcr.io

FROM ${CONTAINER_REGISTRY_URL}/tiagocodecom/back-office:${BACK_OFFICE_VERSION} AS back-office

LABEL author="Tiagocode <santiagomm1997@gmail.com>"
LABEL mantainer="Tiagocode <santiagomm1997@gmail.com>"

FROM wodby/drupal-php:8.3

USER root

COPY --chown=root:root --chmod=777 --from=back-office /var/www /var/www/html/

RUN set -ex; \
    cd /var/www/html; \
    chown -R wodby:wodby /var/www/html; \
    mkdir -p web/sites/default/files; \
    chmod 777 web/sites/default/files; \
    cp web/sites/default/default.settings.php web/sites/default/settings.php; \
    chown wodby:wodby web/sites/default/settings.php; \
    chmod 777 web/sites/default/settings.php; \
    su-exec wodby composer install;  \
    su-exec wodby composer clear-cache;

USER wodby
