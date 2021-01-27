#!/bin/sh
set -e

# start newrelic daemon
NEWRELIC_INI=/usr/local/etc/php/conf.d/newrelic.ini

sed -i \
    -e "s/newrelic.license =.*/newrelic.license = \"${PICPAY_NEWRELIC_LICENSE_KEY}\"/" \
    -e "s/newrelic.appname =.*/newrelic.appname = \"${NEW_RELIC_APP_NAME}\"/" \
    $NEWRELIC_INI;
sed -i "s|;newrelic.daemon.app_timeout.*|newrelic.daemon.app_timeout = 12h|" $NEWRELIC_INI
sed -i "s/;newrelic.daemon.app_connect_timeout =.*/newrelic.app_connect_timeout = 10s/" $NEWRELIC_INI
sed -i "s/;newrelic.daemon.start_timeout =.*/newrelic.daemon.start_timeout = 5s/" $NEWRELIC_INI

# ps aux | grep newrelic
/usr/bin/newrelic-daemon -c /etc/newrelic/newrelic.cfg
wait

# Fix newrelic for php-cli
# https://discuss.newrelic.com/t/relic-solution-single-php-script-docker-containers/80386
php -i > /dev/null
sleep 1;

exec $@;
wait

sleep 60