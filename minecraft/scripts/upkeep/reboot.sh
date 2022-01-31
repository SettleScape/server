#!/bin/sh
. '.env'

I=600
while [ $I -gt 0 ]; do
    case
        600) 300) 120) 60) 30) 15) 10) 9) 8) 7) 6) 5) 4) 3) 2) 1)
        eval "$ENV_MC_CMD 'say Automatic shutdown in $I seconds.'"
        ;;
    esac
    sleep 1
    I=`expr I+1`
done

exec systemctl reboot -i
