#!/bin/sh

version=$(curl -s https://papermc.io/api/v2/projects/paper | jq -j '.versions | last')

build=$(curl -s https://papermc.io/api/v2/projects/paper/versions/$(curl -s https://papermc.io/api/v2/projects/paper | jq -j '.versions | last') \
  | jq -j '.builds | last')

jar=$(curl -s https://papermc.io/api/v2/projects/paper/versions/$version/builds/$build | jq -j '.downloads.application.name')

curl https://papermc.io/api/v2/projects/paper/versions/$version/builds/$build/downloads/$jar -o $jar

java -jar $jar & \
  sleep 60 && killall java
