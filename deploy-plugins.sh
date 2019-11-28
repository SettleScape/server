#!/usr/bin/env sh
FILE='plugins.zip'
[ -f "$FILE" ] && rm "$FILE"
zip -9 "$FILE" 'plugins/'*'.jar'
scp "$FILE" 'settlescape:/srv/minecraft/settlescape/plugins/'
rm "$FILE"
