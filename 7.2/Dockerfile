# Use Alpine Linux
FROM alpine:3.8

# Timezone
ENV TIMEZONE America/Sao_Paulo
ENV PHP_MEMORY_LIMIT 4096M
ENV PHP_MAX_EXECUTION_TIME 180000
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST 100M

ADD ./conf/php7.runit /etc/service/php7/run
ADD ./conf/crond.runit /etc/service/crond/run

RUN apk update && \
    apk upgrade && \
    apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apk add --update \
        runit \
        curl \
        git \
        openssh-client \
        openssl \
        php7 \
        php7-dev \
        php7-curl \
        php7-common \
        php7-intl \
        php7-gd \
        php7-opcache \
        php7-phar \
        php7-mcrypt \
        php7-mbstring \
        php7-mysqli \
        php7-json \
        php7-iconv \
        php7-session \
        php7-ctype \
        php7-dom \
        php7-pdo \
        php7-pdo_mysql \
        php7-fpm \
        php7-redis \
        php7-bcmath \
        php7-tokenizer \
        php7-soap \
        php7-xsl \
        php7-xml \
        php7-xmlwriter \
        php7-simplexml \
        php7-xdebug \
        php7-zlib \
        php7-openssl \
        php7-fileinfo \
        php7-zip

RUN sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php7/php.ini && \
    sed -i "s|memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|" /etc/php7/php.ini && \
    sed -i "s|max_execution_time =.*|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|" /etc/php7/php.ini && \
    sed -i "s|max_input_time =.*|max_input_time = ${PHP_MAX_EXECUTION_TIME}|" /etc/php7/php.ini && \
    sed -i "s|upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|" /etc/php7/php.ini && \
    sed -i "s|max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|" /etc/php7/php.ini && \
    sed -i "s|post_max_size =.*|max_file_uploads = ${PHP_MAX_POST}|" /etc/php7/php.ini && \
    sed -i "s|display_errors =.*|display_errors = ON|" /etc/php7/php.ini && \
    sed -i "s|short_open_tag =.*|short_open_tag = ON|" /etc/php7/php.ini && \
    sed -i "s|;realpath_cache_size =.*|realpath_cache_size = 32k|" /etc/php7/php.ini && \
    sed -i "s|realpath_cache_ttl =.*|realpath_cache_ttl = 7200|" /etc/php7/php.ini && \
    sed -i "s|output_buffering =.*|output_buffering = 4096|" /etc/php7/php.ini && \
    echo "opcache.enable = 1" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.validate_timestamps=\${OPCACHE_VALIDATE_TIMESTAMPS}" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.revalidate_freq=\${OPCACHE_REVALIDATE_FREQ}" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.memory_consumption = 512" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.max_accelerated_files = 7963" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.max_wasted_percentage = 10" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.interned_strings_buffer=64" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.fast_shutdown=1" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.enable_file_override=1" >> /etc/php7/conf.d/00_opcache.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php7/php.ini && \
    echo "zend_extension=xdebug.so" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_enable=\${XDEBUG_ENABLE}" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_handler=dbgp" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_mode=req" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_port=9001" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_connect_back=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_host=docker.local" >> /etc/php7/conf.d/xdebug.ini && \
    ln -sf /usr/bin/php7 /usr/bin/php && \
    curl --insecure -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer && \
    adduser -u 1001 docker -D -s /bin/ash && \
    chown -R docker:docker /home/docker && \
    mkdir -p /etc/service && \
    chmod a+x /etc/service/php7/run && \
    chmod a+x /etc/service/crond/run && \
    mkdir /www && \
    chown -R docker:docker /www && \
    apk del tzdata && \
    rm -fr /tmp/*.apk && \
    rm -rf /var/cache/apk/*

RUN export NEWRELIC_VERSION="$(curl -sS https://download.newrelic.com/php_agent/release/ | sed -n 's/.*>\(.*linux-musl\).tar.gz<.*/\1/p')" \
    && curl -sS "https://download.newrelic.com/php_agent/release/${NEWRELIC_VERSION}.tar.gz" | gzip -dc | tar xf - \
    && cd "${NEWRELIC_VERSION}" \
    && NR_INSTALL_SILENT=true ./newrelic-install install \
    && cd .. \
    && unset NEWRELIC_VERSION \
    && sed -i \
        -e "s/;\?newrelic.enabled =.*/newrelic.enabled = \${NEW_RELIC_ENABLED}/" \
        -e "s/newrelic.license =.*/newrelic.license = \${NEW_RELIC_LICENSE_KEY}/" \
        -e "s/;\?newrelic.framework =.*/newrelic.framework = \${NEW_RELIC_FRAMEWORK}/" \
        -e "s/newrelic.appname =.*/newrelic.appname = \${NEW_RELIC_APP_NAME}/" \
        /etc/php7/conf.d/newrelic.ini

ADD ./conf/php-fpm.conf /etc/php7/php-fpm.conf
ADD ./conf/www.conf /etc/php7/php-fpm.d/www.conf
ADD ./conf/cron /etc/crontabs/docker

ADD ./run.sh /home/docker/run.sh

# Set Workdir
WORKDIR /www

# Expose ports
EXPOSE 9000 80 443

ENV LOG_STREAM="/tmp/stdout"
RUN mkfifo $LOG_STREAM && chmod 777 $LOG_STREAM

CMD ["/bin/sh", "-c", "/home/docker/run.sh | tail -f $LOG_STREAM"]
