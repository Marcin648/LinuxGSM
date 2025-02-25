#!/bin/bash
# LinuxGSM core_legacy.sh module
# Author: Daniel Gibbs
# Contributors: http://linuxgsm.com/contrib
# Website: https://linuxgsm.com
# Description: Code for backwards compatability with older versions of LinuxGSM.

moduleselfname="$(basename "$(readlink -f "${BASH_SOURCE[0]}")")"

# This is to help the transition to v20.3.0 and above
legacy_versions_array=(v20.2.1 v20.2.0 v20.1.5 v20.1.4 v20.1.3 v20.1.2 v20.1.1 v20.1.0 v19.12.5 v19.12.4 v19.12.3 v19.12.2 v19.12.1 v19.12.0)
for legacy_version in "${legacy_versions_array[@]}"; do
	if [ "${version}" == "${legacy_version}" ]; then
		legacymode=1
	fi
done

if [ -n "${webadminuser}" ]; then
	httpuser="${webadminuser}"
fi

if [ -n "${webadminpass}" ]; then
	httppassword="${webadminpass}"
fi

if [ -n "${webadminport}" ]; then
	httpport="${webadminport}"
fi

if [ -n "${webadminip}" ]; then
	httpip="${webadminip}"
fi

if [ -n "${gameworld}" ]; then
	worldname="${gameworld}"
fi

if [ -n "${autosaveinterval}" ]; then
	saveinterval="${autosaveinterval}"
fi

if [ -z "${serverfiles}" ]; then
	serverfiles="${filesdir}"
fi

if [ -z "${logdir}" ]; then
	logdir="${rootdir}/log"
fi

if [ -z "${lgsmlogdir}" ]; then
	lgsmlogdir="${scriptlogdir}"
fi

if [ -z "${lgsmlog}" ]; then
	lgsmlog="${scriptlog}"
fi

if [ -z "${lgsmlogdate}" ]; then
	lgsmlogdate="${scriptlogdate}"
fi

if [ -z "${steamcmddir}" ]; then
	steamcmddir="${HOME}/.steam/steamcmd"
fi

if [ -z "${lgsmdir}" ]; then
	lgsmdir="${rootdir}/lgsm"
fi

if [ -z "${tmpdir}" ]; then
	tmpdir="${lgsmdir}/tmp"
fi

if [ -z "${alertlog}" ]; then
	alertlog="${emaillog}"
fi

if [ -z "${servicename}" ]; then
	servicename="${selfname}"
fi

# Alternations to workshop variables.
if [ -z "${wsapikey}" ]; then
	if [ "${workshopauth}" ]; then
		wsapikey="${workshopauth}"
	elif [ "${authkey}" ]; then
		wsapikey="${authkey}"
	fi
fi

if [ -z "${wscollectionid}" ]; then
	if [ "${workshopauth}" ]; then
		wscollectionid="${ws_collection_id}"
	elif [ "${authkey}" ]; then
		wscollectionid="${workshopcollectionid}"
	fi
fi

if [ -z "${wsstartmap}" ]; then
	if [ "${ws_start_map}" ]; then
		wscollectionid="${ws_start_map}"
	fi
fi

# Added as part of migrating functions dir to modules dir.
# Will remove functions dir if files in modules dir older than 14 days
functionsdir="${lgsmdir}/modules"
if [ -d "${lgsmdir}/functions" ]; then
	if [ "$(find "${lgsmdir}/modules"/ -type f -mtime +"14" | wc -l)" -ne "0" ]; then
		rm -rf "${lgsmdir:?}/functions"
	fi
fi

fn_parms() {
	fn_reload_startparameters
	parms="${startparameters}"
}
