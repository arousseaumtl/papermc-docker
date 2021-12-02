FROM archlinux:latest
RUN groupadd minecraft; useradd -m -g minecraft -s /bin/bash minecraft
RUN pacman -Syu --noconfirm
RUN pacman --noconfirm -S jq jre-openjdk python3 nano
USER minecraft
RUN mkdir -p /home/minecraft/srv/papermc
COPY config/* /home/minecraft/srv/papermc/
COPY scripts/* /home/minecraft/srv/papermc/
USER root
RUN chmod +x /home/minecraft/srv/papermc/*.sh
USER minecraft
EXPOSE 25565
WORKDIR /home/minecraft/srv/papermc
RUN ./compile.sh
