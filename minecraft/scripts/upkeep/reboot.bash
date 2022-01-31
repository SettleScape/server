#!/bin/bash
source '../var/env.sh'
set -e

declare -i I=600
while [[ $I -gt 0 ]]; do
    case $I in
        600) ;& 
        300) ;& 
        120) ;& 
         60) ;& 
         30) ;& 
         15) ;& 
         10) ;& 
          9) ;& 
          8) ;& 
          7) ;& 
          6) ;& 
          5) ;& 
          4) ;& 
          3) ;& 
          2) ;& 
          1) ;&
          0) eval "$ENV_MC_CMD 'say Automatic shutdown in $I seconds.'" ;;
    esac
    # echo $I
    sleep 1
    I=$((I-1))
done

exec systemctl reboot -i
