###########################################################
# Dockerfile that builds a Palworld Gameserver
###########################################################
FROM cm2network/steamcmd:root as build_stage

LABEL maintainer="jan@civitelli.de"

ENV STEAMAPPID 2394010
ENV STEAMAPP palworld
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY etc/entry.sh "${HOMEDIR}/entry.sh"

RUN set -x \
	# Install, update & upgrade packages
	&& apt update \
	&& apt install -y --no-install-recommends --no-install-suggests \
		wget=1.21-1+deb11u1 \
		ca-certificates=20210119 \
		lib32z1=1:1.2.11.dfsg-2+deb11u2 \
		xdg-user-dirs \
	&& mkdir -p "${STEAMAPPDIR}" \
	# Add entry script
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/* \
	apt clean

FROM build_stage AS bullseye-base

ENV PW_SERVERNAME="New ${STEAMAPP} Server" \
    PW_PORT=8211 \
    PW_RCONPORT=25575 \
    PW_PW="changeme" \
	PW_MAXPLAYERS=32 \
    PW_LOCATION="de" \
    PW_ADMINPW="changeme"


COPY etc/DefaultPalWorldSettings_temp.ini "${HOMEDIR}/palworld-dedicated/DefaultPalWorldSettings_temp.ini"
	
# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

EXPOSE 8211/tcp \
	8211/udp \
	25575/tcp