FROM cm2network/steamcmd

ENV CSTRIKE "${HOMEDIR}/cstrike"
ENV PORT 27015
ENV MAP de_dust2
ENV MAXPLAYERS 16
ENV SV_LAN 0

RUN ./steamcmd.sh +login anonymous +force_install_dir ../cstrike +app_update 90 validate +quit || :
RUN ./steamcmd.sh +login anonymous +force_install_dir ../cstrike +app_update 70 validate +quit || :
RUN ./steamcmd.sh +login anonymous +force_install_dir ../cstrike +app_update 10 validate +quit || :
RUN ./steamcmd.sh +login anonymous +force_install_dir ../cstrike +app_update 90 validate +quit

WORKDIR ${CSTRIKE}
USER steam

ADD files/steam_appid.txt steam_appid.txt

# Add maps
ADD files/mapcycle.txt ${CSTRIKE}/cstrike/mapcycle.txt

# Add default config
ADD files/server.cfg ${CSTRIKE}/cstrike/server.cfg

# Install metamod
RUN mkdir -p ${CSTRIKE}/cstrike/addons/metamod/dlls
RUN curl -sqL "https://github.com/z0mbyHG/Home-Assistant-ADDONS/raw/refs/heads/main/cs16_amx_test/files/metamod.tar.gz" | tar -C ${CSTRIKE}/cstrike/addons/metamod/dlls -zxvf -
ADD files/liblist.gam ${CSTRIKE}/cstrike/liblist.gam
# Remove this line if you aren't going to install/use amxmodx, dproto and podbot
ADD files/plugins.ini ${CSTRIKE}/cstrike/addons/metamod/plugins.ini

# Install dproto
RUN mkdir -p ${CSTRIKE}/cstrike/addons/dproto
ADD files/dproto_i386.so ${CSTRIKE}/cstrike/addons/dproto/dproto_i386.so
ADD files/dproto.cfg ${CSTRIKE}/cstrike/dproto.cfg

# Install AMX mod X
RUN curl -sqL "https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5474-base-linux.tar.gz" | tar -C ${CSTRIKE}/cstrike/ -zxvf -
RUN curl -sqL "https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5474-cstrike-linux.tar.gz" | tar -C ${CSTRIKE}/cstrike/ -zxvf -
ADD files/maps.ini ${CSTRIKE}/cstrike/addons/amxmodx/configs/maps.ini

EXPOSE 27015/udp
ENTRYPOINT ./hlds_run -game cstrike -strictportbind -ip 0.0.0.0 -port $PORT +sv_lan $SV_LAN +map $MAP -maxplayers $MAXPLAYERS
