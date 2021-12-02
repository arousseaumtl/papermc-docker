#!/bin/sh

if docker images 2>&1 | grep -q 'papermc';
 then docker run papermc /bin/bash -c "pacman -Syu --noconfirm && \
  /home/minecraft/srv/papermc/compile.sh & \
  sleep 30 && killall java";
 else docker build .;
fi
