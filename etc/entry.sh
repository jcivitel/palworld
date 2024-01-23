#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

# Download Updates

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
				+login "anonymous" \
				+app_update "${STEAMAPPID}" \
				+quit

# Switch to server directory
cd "${STEAMAPPDIR}"

cp DefaultPalWorldSettings_temp.ini DefaultPalWorldSettings.ini

sed -i -e "s/PW_SERVERNAME/${PW_SERVERNAME}/g" "${HOMEDIR}/palworld-dedicated/DefaultPalWorldSettings.ini" \
	-e "s/PW_PORT/${PW_PORT}/g" "${HOMEDIR}/palworld-dedicated/DefaultPalWorldSettings.ini" \
	-e "s/PW_MAXPLAYERS/${PW_MAXPLAYERS}/g" "${HOMEDIR}/palworld-dedicated/DefaultPalWorldSettings.ini" \
	-e "s/PW_RCONPORT/${PW_RCONPORT}/g" "${HOMEDIR}/palworld-dedicated/DefaultPalWorldSettings.ini" \
	-e "s/PW_PW/${PW_PW}/g" "${HOMEDIR}/palworld-dedicated/DefaultPalWorldSettings.ini" \
	-e "s/PW_LOCATION/${PW_LOCATION}/g" "${HOMEDIR}/palworld-dedicated/DefaultPalWorldSettings.ini" \
	-e "s/PW_ADMINPW/${PW_ADMINPW}/g" "${HOMEDIR}/palworld-dedicated/DefaultPalWorldSettings.ini"	

# Start Server
./PalServer.sh \
	-useperfthreads \
	-NoAsyncLoadingThread \
	-UseMultithreadForDS