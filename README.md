## alpine-php-nginx-pagespeed ##

This docker image has PHP7, PHP-FPM and Pagespeed enabled Nginx

# Supported tags and respective `Dockerfile` links

-	[`builder`, `latest` (*builder/Dockerfile*)](https://github.com/escaleseo/alpine-php-nginx-pagespeed/blob/development/builder/Dockerfile)
-	[`light` (*light/Dockerfile*)](https://github.com/escaleseo/alpine-php-nginx-pagespeed/blob/development/light/Dockerfile)

# The difference between tags

### light

PHP7, PHP-FPM, PHP-ZIP, PHP-MYSQLI, PHP-GD, Pagespeed enabled Nginx in supervisord.

It also installs [New Relic PHP agent](https://docs.newrelic.com/docs/agents/php-agent).
In order to enable it you need to set the following variables:

- NR_ENABLED
Enable newrelic-daemon on container startup.

- NR_APP_NAME
Your New Relic APM name.

- NR_LICENSE_KEY
Your New Relic License key. It can be found in your Account Settings menu in New Relic user panel.

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

It also installs [PHP Composer](https://getcomposer.org/).

It does not installs New Relic PHP agent.
