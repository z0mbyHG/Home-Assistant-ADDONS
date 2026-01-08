FROM ghcr.io/hassio-addons/debian-base:stable

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    jq \
    lib32gcc-s1 \
    lib32stdc++6 \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /steamcmd \
 && curl -sSL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
 | tar -xz -C /steamcmd

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]

