#!/bin/bash

GAME_ROOT=/hlds
GAME_CSTRIKE=${GAME_ROOT}/cstrike
CONFIG_ROOT=/config/cs16
CONFIG_CSTRIKE=${CONFIG_ROOT}/cstrike

mkdir -p ${CONFIG_ROOT}

# Prvi start: kopiraj kompletan cstrike u /config
if [ ! -d "${CONFIG_CSTRIKE}" ]; then
  echo "[CS16] First start detected – copying cstrike to /config"
  cp -a ${GAME_CSTRIKE} ${CONFIG_CSTRIKE}
fi

# Zamijeni originalni cstrike symlinkom
rm -rf ${GAME_CSTRIKE}
ln -s ${CONFIG_CSTRIKE} ${GAME_CSTRIKE}

# Safety files
touch ${GAME_CSTRIKE}/listip.cfg
touch ${GAME_CSTRIKE}/banned.cfg

cd ${GAME_ROOT}

./hlds_run \
 -game cstrike \
 -port ${PORT} \
 -maxplayers ${MAXPLAYERS} \
 +map ${MAP} \
 +sv_lan 0 \
 +hostname "${HOSTNAME}"
