ARG BACK_OFFICE_VERSION=latest
ARG CONTAINER_REGISTRY=ghcr.io

FROM test_image_website AS website

LABEL author="Tiagocode <santiagomm1997@gmail.com>"
LABEL mantainer="Tiagocode <santiagomm1997@gmail.com>"

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /var/www/app

ENTRYPOINT [ "/entrypoint.sh" ]