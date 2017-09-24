#!/bin/sh

docker build -t venantvr/selenium-chrome .

hostIp=$(ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')
# 172.17.0.1

docker run -ti --rm -e DISPLAY=$DISPLAY \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/shm:/dev/shm \
    -v /var/www/preprod:/var/www/preprod \
    --shm-size 8G \
    --add-host='recipe.concilio.com:'$hostIp \
    --add-host='preprod.concilio.com:'$hostIp \
    --device /dev/snd \
    --device /dev/dri \
    --group-add audio \
    --group-add video \
    --security-opt \
    seccomp:./chrome.json \
    venantvr/selenium-chrome bash
    # \
    # /home/developer/start.sh   
    # bash

