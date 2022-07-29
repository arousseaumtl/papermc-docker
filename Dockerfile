FROM debian:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    curl \
    jq \
    nano \
    python3
RUN latest_jre=$(apt-cache search 'jre$' | python3 -c 'import sys; print(sorted(sys.stdin, reverse=True)[0].strip().split(" ")[0])'); \
    apt-get install -y $latest_jre

RUN groupadd minecraft; useradd -m -g minecraft -s /bin/bash minecraft
RUN mkdir /export; mkdir -p /home/minecraft/srv/papermc
COPY files/* /home/minecraft/srv/papermc/
RUN chmod +x /home/minecraft/srv/papermc/*.sh
RUN chown minecraft:minecraft /export; chown -R minecraft:minecraft /home/minecraft/srv/papermc
USER minecraft

WORKDIR /home/minecraft/srv/papermc
EXPOSE 25565

ENTRYPOINT ["/home/minecraft/srv/papermc/entrypoint.sh"]
