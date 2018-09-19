## alpine-php-nginx-pagespeed ##

This docker image has PHP7, PHP-FPM and Pagespeed enabled Nginx

# Supported tags and respective `Dockerfile` links

-	[`builder`, `latest` (*builder/Dockerfile*)](builder/Dockerfile)
-	[`light` (*light/Dockerfile*)](light/Dockerfile)

# The difference between tags

### light

PHP7, PHP-FPM, PHP-ZIP, PHP-MYSQLI, PHP-GD, Pagespeed enabled Nginx in supervisord.

### builder

Same as light flavor but also has the following Alpine packages:
- gnupg
- nodejs
- nodejs-npm
- git
- unzip
- bash
- make
- gcc
- g++
- libc-dev
- jpeg-dev

It also installs [PHP Composer](https://getcomposer.org/)
