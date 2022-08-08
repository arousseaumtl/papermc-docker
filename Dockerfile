FROM debian:latest

RUN apt-get update; apt-get upgrade -y \ 
  && \
    DEBIAN_FRONTEND=noninteractive \
      apt-get install -y \
      curl \
      jq \
      nano \
      python3 \
  && \
    latest_jre=$(apt-cache search 'jre$' | python3 -c \
    'import sys; print(sorted(sys.stdin, reverse=True)[0].strip().split(" ")[0])'); \
    apt-get install -y $latest_jre

RUN groupadd mc; useradd -m -g mc -s /bin/bash mc
RUN mkdir /export; mkdir -p /home/mc/srv/papermc
COPY files/* /home/mc/srv/papermc/
RUN chmod +x /home/mc/srv/papermc/*.sh
RUN chown mc:mc /export; chown -R mc:mc /home/mc/srv/papermc
USER mc

WORKDIR /home/mc/srv/papermc
EXPOSE 25565

ENTRYPOINT ["/home/mc/srv/papermc/entrypoint.sh"]
