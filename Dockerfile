FROM pagespeed/nginx-pagespeed as pagespeed

FROM php:7.2-fpm-alpine

RUN apk add --no-cache \
    zlib-dev \
    libpng-dev \
    python2 \
    py2-pip

RUN docker-php-ext-install \
    zip \
    mysqli \
    gd

COPY --from=pagespeed /usr/local/bin/envsubst /usr/local/bin
COPY --from=pagespeed /usr/sbin/nginx /usr/sbin/nginx
COPY --from=pagespeed /usr/lib/nginx/modules/ /usr/lib/nginx/modules/
COPY --from=pagespeed /etc/nginx /etc/nginx
COPY --from=pagespeed /usr/share/nginx/html/ /usr/share/nginx/html/

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
