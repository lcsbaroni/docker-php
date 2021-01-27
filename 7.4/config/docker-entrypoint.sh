#!/bin/sh
set -e

# start newrelic daemon
NEWRELIC_INI=/usr/local/etc/php/conf.d/newrelic.ini
if [ -f "$NEWRELIC_INI" ]; then
    sed -i \
        -e "s/newrelic.license =.*/newrelic.license = \"${PICPAY_NEWRELIC_LICENSE_KEY}\"/" \
        -e "s/newrelic.appname =.*/newrelic.appname = \"${NEW_RELIC_APP_NAME}\"/" \
        $NEWRELIC_INI

    /usr/bin/newrelic-daemon -c /etc/newrelic/newrelic.cfg --pidfile /var/run/newrelic-daemon.pid
fi

# if [ -d "/app/storage" ]; then
#   chown -R www-data:www-data /app/storage
# fi

exec $@