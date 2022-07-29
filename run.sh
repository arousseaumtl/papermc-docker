#!/bin/bash

APP_NAME=$(basename $(pwd))
MESSAGE=""

if [ $# -eq 0 ]
  then
    echo "Usage: run.sh [--run (-r), --build (-b), --upgrade (-u), -tty (-t), --export (-e)]"
  else
    [[ "$@" =~ "--run" || "$@" =~ "-r" ]] && ( docker run -p 25565:25565 $APP_NAME )
    [[ "$@" =~ "--build" || "$@" =~ "-b" ]] && ( docker build -t $APP_NAME:latest . )
    [[ "$@" =~ "--upgrade" || "$@" =~ "-u" ]] && ( docker run -p 25565:25565 $APP_NAME upgrade )
    [[ "$@" =~ "--tty" || "$@" =~ "-t" ]] && ( docker run -it --entrypoint /bin/bash $APP_NAME )
    [[ "$@" =~ "--export" || "$@" =~ "-e" ]] && ( docker run -v "$(pwd)"/files/export:/export --entrypoint "/bin/bash" $APP_NAME \
      -c "cp -rp /home/minecraft/srv/papermc/* /export" )
fi
