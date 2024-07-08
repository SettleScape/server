#!/bin/sh
## Detects the package manager used by the current system, and uses it to update said system.
set -e

## Suppress stderr
function noerr {
	"$@" 2>/dev/null
}

## Do the thing
  if [[ ! -z "$(noerr which 'apt')"    ]]; then  ## first `apt`, because Debian-derivatives are EVERYWHERE.
    apt-get update &&\
    apt-get dist-upgrade
    exit $?
elif [[ ! -z "$(noerr which 'yum')"    ]]; then  ## then `yum`, because RHEL and its derivatives are widespread.
    exec yum update -y
elif [[ ! -z "$(noerr which 'zypper')" ]]; then  ## then `zypper`, because OpenSuSE is less widespread than RHEL-ish distros, but still mainstream...ish.
	  exec zypper dup
elif [[ ! -z "$(noerr which 'pacman')" ]]; then  ## then `pacman`, just in case.
    exec pacman -Syuu
else
    echo 'Unsupported package manager.' >&2
    exit 1
  fi
