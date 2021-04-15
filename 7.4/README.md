# lcsbaroni/docker-php:7.4

PHP-FPM image based on Alpine Linux

Image is based on the oficial image of alpine

## Docker image usage

```
docker run [docker-options] lcsbaroni/docker-php:7.4
```

## Examples

Typical basic usage:

```
docker run -it lcsbaroni/docker-php:7.4
```

Typical usage in Dockerfile:

```
FROM lcsbaroni/docker-php:7.4
RUN echo "<?php phpinfo() ?>" > /var/www/localhost/htdocs/index.php
```

Typical usage:

```
docker run -it --link=somedb:db lcsbaroni/docker-php:7.4
```

Typical usage on docker-compose:

```
docker-compose up -d
```