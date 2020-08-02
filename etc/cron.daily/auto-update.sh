#!/bin/sh
set -e
  if [[ ! -z "$(which 'apt')"    ]] && [[ "$(which 'apt')"    != *'not found'* ]]; then  ## aptitude etc come first because Debian-derivatives are EVERYWHERE
    apt-get update &&\
    apt-get dist-upgrade
elif [[ ! -z "$(which 'yum')"    ]] && [[ "$(which 'yum')"    != *'not found'* ]]; then  ## yum next because RHEL is widespread
    yum update -y
elif [[ ! -z "$(which 'zypper')" ]] && [[ "$(which 'zypper')" != *'not found'* ]]; then  ## then zypper, because OpenSuSE is less widespread than RHEL-ish distros, but still mainstream...ish.
	zypper update
  fi
