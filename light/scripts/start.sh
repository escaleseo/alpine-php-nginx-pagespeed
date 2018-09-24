#!/bin/sh

NR_DEBUG=${NR_DEBUG:-false}
NR_ENABLED=${NR_ENABLED:-false}
XDEBUG_ENABLED=${XDEBUG_ENABLED:-false}

# if the user wants to debug new relic
if [ $NR_DEBUG = true ]; then
    sed -i "/;newrelic.loglevel = .*/c\newrelic.loglevel = \"verbosedebug\""                               /scripts/newrelic.ini
    sed -i "/;newrelic.daemon.loglevel = .*/c\newrelic.daemon.loglevel = \"debug\""                        /scripts/newrelic.ini
    sed -i "/;newrelic.daemon.auditlog = .*/c\newrelic.daemon.auditlog = \"/var/log/newrelic/audit.log\""  /scripts/newrelic.ini
fi

# if the user wants to enable new relic
if [ $NR_ENABLED = true ]; then
    # make usage of the virtual port
    sed -i "/;newrelic.daemon.port = .*/c\newrelic.daemon.port = \"@newrelic-daemon\"" /scripts/newrelic.ini

    # set the new relic key
    sed -i -e "s/"REPLACE_WITH_REAL_KEY"/$NR_LICENSE_KEY/g" /scripts/newrelic.ini

    # set the new relic application name
    sed -i -e "s/PHP Application/$NR_APP_NAME/g" /scripts/newrelic.ini

    # enable new relic for fpm
    cp /scripts/newrelic.ini /usr/local/etc/php/conf.d/00_newrelic.ini

    # dummy PHP call to start daemon connection to New Relic servers
    php -i > /dev/null
    php -i > /dev/null
    php -i > /dev/null
fi

if [ $XDEBUG_ENABLED = true ]; then
    # enable xdebug extension
    sed -i "/;zend_extension=xdebug.so/c\zend_extension=xdebug.so" /etc/php7/conf.d/xdebug.ini
fi

if [ ${REGISTRATION_PHOTO_PATH+x} ]; then
    echo "REGISTRATION_PHOTO_PATH is set to '$REGISTRATION_PHOTO_PATH'"
    chmod 777 $REGISTRATION_PHOTO_PATH
fi

# run the original command
exec "$@"
