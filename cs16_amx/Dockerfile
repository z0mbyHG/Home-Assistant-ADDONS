FROM debian:11-slim

ENV STEAMCMD_DIR=/steamcmd
ENV HLDS_DIR=/hlds

RUN dpkg --add-architecture i386 \
 && apt update \
 && apt install -y \
    lib32gcc-s1 \
    lib32stdc++6 \
    libcurl4-gnutls-dev:i386 \
    libcurl4:i386
    wget \
    unzip \
    tar \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# SteamCMD
RUN mkdir -p ${STEAMCMD_DIR} \
 && wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
 && tar -xzf steamcmd_linux.tar.gz -C ${STEAMCMD_DIR}

# Install CS 1.6 (appid 90)
RUN ${STEAMCMD_DIR}/steamcmd.sh +login anonymous \
 +force_install_dir ${HLDS_DIR} \
 +app_update 90 validate \
 +quit

# =========================
# Metamod 1.21.1
# =========================
WORKDIR /tmp
RUN wget https://www.amxmodx.org/release/metamod-1.21.1-am.zip \
 && unzip metamod-1.21.1-am.zip -d metamod \
 && mkdir -p ${HLDS_DIR}/cstrike/addons \
 && cp -r metamod/addons/metamod ${HLDS_DIR}/cstrike/addons/

# =========================
# AMX Mod X 1.10 (latest)
# =========================
RUN wget https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5474-base-linux.tar.gz \
 && tar -xzf amxmodx-1.10.0-git5474-base-linux.tar.gz -C ${HLDS_DIR}/cstrike \
 && wget https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5474-cstrike-linux.tar.gz \
 && tar -xzf amxmodx-1.10.0-git5474-cstrike-linux.tar.gz -C ${HLDS_DIR}/cstrike

# =========================
# Metamod → AMXX hook
# =========================
RUN echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" \
 > ${HLDS_DIR}/cstrike/addons/metamod/plugins.ini

# =========================
# liblist.gam fix (SteamCMD)
# =========================
RUN sed -i \
 's|gamedll_linux.*|gamedll_linux "addons/metamod/dlls/metamod.so"|' \
 ${HLDS_DIR}/cstrike/liblist.gam
RUN touch /hlds/cstrike/listip.cfg \
 && touch /hlds/cstrike/banned.cfg

# Run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

WORKDIR /hlds
EXPOSE 27015/udp
CMD ["/run.sh"]
