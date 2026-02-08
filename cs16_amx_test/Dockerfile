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
ADD files/mapcycle.txt cstrike/mapcycle.txt

# Add default config
ADD files/server.cfg cstrike/server.cfg

# Install metamod
RUN curl -sL https://www.amxmodx.org/release/metamod-1.21.1-am.zip \
 && unzip metamod-1.21.1-am.zip -d cstrike/ \
ADD files/liblist.gam cstrike/liblist.gam
# Remove this line if you aren't going to install/use amxmodx, dproto and podbot
ADD files/plugins.ini cstrike/addons/metamod/plugins.ini

# Install dproto
RUN mkdir -p cstrike/addons/dproto
ADD files/dproto_i386.so cstrike/addons/dproto/dproto_i386.so
ADD files/dproto.cfg cstrike/dproto.cfg

# Install AMX mod X
RUN curl -sqL "https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5474-base-linux.tar.gz" | tar -C cstrike/ -zxvf -
RUN curl -sqL "https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5474-cstrike-linux.tar.gz" | tar -C cstrike/ -zxvf -
ADD files/maps.ini cstrike/addons/amxmodx/configs/maps.ini

EXPOSE 27015/udp
ENTRYPOINT ./hlds_run -game cstrike -strictportbind -ip 0.0.0.0 -port $PORT +sv_lan $SV_LAN +map $MAP -maxplayers $MAXPLAYERS
