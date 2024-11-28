ARG PHP_VERSION=8.3
ARG BACK_OFFICE_VERSION=latest
ARG CONTAINER_REGISTRY_URL=ghcr.io

FROM ${CONTAINER_REGISTRY_URL}/tiagocodecom/back-office:${BACK_OFFICE_VERSION} AS back-office

LABEL author="Tiagocode <santiagomm1997@gmail.com>"
LABEL mantainer="Tiagocode <santiagomm1997@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/tiagocodecom/back-office"

FROM wodby/drupal-php:${PHP_VERSION}

ARG APP_NAME
ARG DRUPAL_VERSION

ENV DRUPAL_VER="${DRUPAL_VERSION}" \
    DOCROOT_SUBDIR="web" \
    APP_NAME=${APP_NAME}

USER root

RUN set -ex; \
    mv /usr/local/bin/actions.mk /usr/local/bin/drupal-php.mk; \
    mkdir -p /usr/src/drupal; \
    chown wodby:wodby -R /usr/src;

COPY --chown=root:root --chmod=777 --from=back-office /var/www /usr/src/drupal

RUN set -ex; \
    cd /usr/src/drupal; \
    cp web/sites/default/default.settings.php web/sites/default/settings.php; \
    mkdir -p web/sites/default/files; \
    chmod 777 -R web/sites/default/files; \
    chown wodby:wodby web/sites/default/settings.php web/sites/default/files; \
    if [[ -z "${PHP_DEV}" ]]; then \
        echo "$(cat /etc/sudoers.d/wodby), /usr/local/bin/init" > /etc/sudoers.d/wodby; \
    fi; 

COPY templates/settings.php.tmpl /etc/gotpl/
COPY init /docker-entrypoint-init.d/
COPY bin /usr/local/bin/

RUN chmod +x /usr/local/bin/init
RUN chmod +x /usr/local/bin/get_drupal_version

USER wodby
