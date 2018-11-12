# lcsbaroni/docker-php:7.2

PHP-FPM image based on Alpine Linux

Image is based on the oficial image of alpine

## Docker image usage

```
docker run [docker-options] lcsbaroni/docker-php:7.2
```

## Examples

Typical basic usage:

```
docker run -it lcsbaroni/docker-php:7.2
```

Typical usage in Dockerfile:

```
FROM lcsbaroni/docker-php:7.2
RUN echo "<?php phpinfo() ?>" > /var/www/localhost/htdocs/index.php
```

Typical usage:

```
docker run -it --link=somedb:db lcsbaroni/docker-php:7.2
```

Typical usage on docker-compose:

```
docker-compose up -d
```