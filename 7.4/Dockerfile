FROM php:7.4-fpm-alpine3.13

RUN apk update && \
    apk upgrade && \
    apk add \
        ${PHPIZE_DEPS} \
        # oniguruma \
        libpng \
        openssl-dev \
        libxml2-dev \
        && rm -rf /var/cache/apk/*

RUN docker-php-ext-install \
        pcntl \
        # xml \
        # posix \
        # tokenizer \
        # ctype \
        opcache

# RUN chmod -R 755 /usr/local/lib/php/extensions/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
    && mkdir -p /app

RUN adduser -u 1000 www -D -s /bin/ash && \
    chown -R www:www /home/www && \
    chown -R www:www /app

RUN mkdir -p /etc/default \
    && export NEWRELIC_VERSION="$(curl -sS https://download.newrelic.com/php_agent/release/ | sed -n 's/.*>\(.*linux-musl\).tar.gz<.*/\1/p')" \
    && curl -sS "https://download.newrelic.com/php_agent/release/${NEWRELIC_VERSION}.tar.gz" | gzip -dc | tar xf - \
    && cd "${NEWRELIC_VERSION}" \
    && cd agent \
    && ln -s x64 x86 \
    && cd - \
    && export NR_INSTALL_SILENT=1 \
    && ./newrelic-install install \
    && cp /etc/newrelic/newrelic.cfg.template /etc/newrelic/newrelic.cfg

COPY config/     /
WORKDIR /app

RUN mkdir -p /app/storage/logs \
    && chown -R www:www /app/storage \
    && chmod +x /docker-entrypoint.sh \
    && chmod +x /docker-cli.sh

EXPOSE 9000

CMD ["/run.sh", "php-fpm -F -O"]