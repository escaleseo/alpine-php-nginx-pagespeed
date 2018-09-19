#!/bin/bash
STATUS=$(curl -X POST -H "Content-Type: application/json" --data '{"docker_tag": "'$1'"}' -s -o /dev/null -w "%{http_code}" https://registry.hub.docker.com/u/escaletech/alpine-php-nginx-pagespeed/trigger/$DOCKER_HUB_TOKEN/)
if [ $STATUS -ne 200 ]; then
    echo '{"docker_tag": "'$1'"}'
    echo "ERROR $STATUS: Something is wrong."
    exit 1
fi
