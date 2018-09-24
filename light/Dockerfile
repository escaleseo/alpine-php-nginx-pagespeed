FROM pagespeed/nginx-pagespeed as pagespeed

FROM php:7.2-fpm-alpine

ENV NR_ENABLED=false \
    NR_APP_NAME="" \
    NR_LICENSE_KEY=""

RUN apk add --update --no-cache \
    zlib-dev \
    libpng-dev \
    python2 \
    py2-pip \
    wget

RUN docker-php-ext-install \
    zip \
    mysqli \
    gd

COPY --from=pagespeed /usr/local/bin/envsubst /usr/local/bin
COPY --from=pagespeed /usr/sbin/nginx /usr/sbin/nginx
COPY --from=pagespeed /usr/lib/nginx/modules/ /usr/lib/nginx/modules/
COPY --from=pagespeed /etc/nginx /etc/nginx
COPY --from=pagespeed /usr/share/nginx/html/ /usr/share/nginx/html/
COPY supervisord.conf /etc/supervisord.conf
COPY scripts /scripts

RUN apk --no-cache upgrade && \
    scanelf --needed --nobanner --format '%n#p' /usr/sbin/nginx /usr/lib/nginx/modules/*.so /usr/local/bin/envsubst \
            | tr ',' '\n' \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
            | xargs apk add --no-cache \
    && \
    apk add --no-cache tzdata

RUN install -g www-data -o www-data -d /var/cache/ngx_pagespeed && \
    mkdir -p /var/cache/nginx/{client_temp,fastcgi_temp,proxy_temp} && \
    mkdir -p /var/log/nginx

RUN mkdir /tmp/newrelic \
    && mkdir /var/log/newrelic \
    && cd /tmp/newrelic \
    && wget -r -l1 -nd -A"linux-musl.tar.gz" https://download.newrelic.com/php_agent/release/ \
    && gzip -dc newrelic*.tar.gz | tar xf - \
    && cd newrelic-php5* \
    && cp ./agent/x64/newrelic-20170718.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718/newrelic.so \
    && cp ./daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon \
    && chmod +x /scripts/*.sh

RUN pip install supervisor

ENTRYPOINT ["/scripts/start.sh"]
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
