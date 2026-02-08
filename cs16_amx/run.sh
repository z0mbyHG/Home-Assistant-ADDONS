#!/bin/bash

cd /hlds

./hlds_run \
 -game cstrike \
 -port ${PORT} \
 -maxplayers ${MAXPLAYERS} \
 +map ${MAP} \
 +sv_lan 0 \
 +hostname "${HOSTNAME}"
