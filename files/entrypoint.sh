#!/bin/bash

upgrade_server() {
  version=$(curl -s https://papermc.io/api/v2/projects/paper | jq -j '.versions | last')
  build=$(curl -s https://papermc.io/api/v2/projects/paper/versions/$version | jq -j '.builds | last')
  jar=$(curl -s https://papermc.io/api/v2/projects/paper/versions/$version/builds/$build | jq -j '.downloads.application.name')
  if
    curl https://papermc.io/api/v2/projects/paper/versions/$version/builds/$build/downloads/$jar -o $jar
  then
    echo "Server Upgraded to version $version-$build"
    return 0
  else
    echo "Server Upgrade Failed"
    return 1
  fi
}

start_server() {
  java -jar $(ls ./*.jar | python3 -c 'import sys; print(sorted(sys.stdin, reverse=True)[0].strip())')
}


if [ $# -eq 0 ]
  then
    if ! ls *.jar
    then
      upgrade_server && \
      start_server
    else
      start_server
    fi
  else
    [[ "$@" =~ "upgrade" ]] && ( upgrade_server )
fi

