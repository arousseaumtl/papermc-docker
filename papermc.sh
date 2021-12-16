#!/bin/sh

if [ $# -eq 0 ]
  then
    echo "Usage: papermc.sh [--run (-r), or --build (-b)]"
  else
    [[ "$@" =~ '--run' || "$@" =~ '-r' ]] && ( docker run -p 25565:25565 -it papermc /home/minecraft/srv/papermc/run.sh )
    [[ "$@" =~ '--build' || "$@" =~ '-b' ]] && ( docker build --rm -t papermc:latest . )
fi
