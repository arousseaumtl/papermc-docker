FROM archlinux:latest
WORKDIR /srv/papermc
COPY config/* /srv/papermc/
COPY scripts/* /srv/papermc/
RUN pacman -Sy
RUN pacman -S --noconfirm jq jre-openjdk python3 nano
EXPOSE 25565
RUN ./compile.sh
