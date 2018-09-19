#!/bin/bash
curl -X POST -H "Content-Type: application/json" --data '{"docker_tag": "'${FLAVOR}'"}' https://registry.hub.docker.com/u/escaletech/alpine-php-nginx-pagespeed/trigger/$DOCKER_HUB_TOKEN/
