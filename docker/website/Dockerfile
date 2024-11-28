ARG RUST_VER=latest
ARG WEBSITE_VERSION=latest
ARG CONTAINER_REGISTRY_URL=ghcr.io

FROM ${CONTAINER_REGISTRY_URL}/tiagocodecom/website:${WEBSITE_VERSION} AS website

LABEL author="Tiagocode <santiagomm1997@gmail.com>"
LABEL mantainer="Tiagocode <santiagomm1997@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/tiagocodecom/website"


FROM rust:${RUST_VER}

ENV APP_ROOT=/var/www/html

USER root

RUN rustup toolchain install nightly
RUN rustup default nightly
RUN rustup target add wasm32-unknown-unknown

RUN set -ex; \
    apk update; \
    apk add --no-cache musl-dev; \
    apk add --no-cache  \
        rsync \
        openssl  \
        openssh \
        curl  \
        bash  \
        git \
        zsh \
        npm \
        libc-dev \
        binaryen;

COPY --chown=root:root --chmod=777 --from=website /var/www /usr/src/app

RUN set -ex; \
    npm install -g sass; \
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash; \
    cargo binstall -y trunk; \
    cargo binstall -y cargo-leptos;

RUN set -ex; \
    mkdir -p /var/www/app;
  
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 3000

ENTRYPOINT [ "/entrypoint.sh" ]
