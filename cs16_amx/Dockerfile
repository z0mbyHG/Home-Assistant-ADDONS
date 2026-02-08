FROM debian:11-slim

ENV STEAMCMD_DIR=/steamcmd
ENV HLDS_DIR=/hlds

RUN dpkg --add-architecture i386 \
 && apt update \
 && apt install -y \
    lib32gcc-s1 \
    lib32stdc++6 \
    wget \
    tar \
    ca-certificates \
 && mkdir -p ${STEAMCMD_DIR}

# SteamCMD
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
 && tar -xvzf steamcmd_linux.tar.gz -C ${STEAMCMD_DIR}

# Install CS 1.6 (appid 90)
RUN ${STEAMCMD_DIR}/steamcmd.sh +login anonymous \
 +force_install_dir ${HLDS_DIR} \
 +app_update 90 validate \
 +quit

# AMX Mod X
WORKDIR /tmp
RUN wget https://www.amxmodx.org/amxmodx-1.9.0-git5294-base-linux.tar.gz \
 && tar -xzf amxmodx-*-base-linux.tar.gz -C ${HLDS_DIR}/cstrike \
 && wget https://www.amxmodx.org/amxmodx-1.9.0-git5294-cstrike-linux.tar.gz \
 && tar -xzf amxmodx-*-cstrike-linux.tar.gz -C ${HLDS_DIR}/cstrike

WORKDIR /hlds
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 27015/udp
CMD ["/run.sh"]
