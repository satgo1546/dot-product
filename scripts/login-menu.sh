#!/bin/bash
temp=$(mktemp)
msg="$(cat /etc/motd)
↑MOTD↑ \$"
dialog --backtitle "$0: \$USER = $USER  \$LANG = $LANG" \
	--title "login-menu.sh" \
	--no-ok --no-cancel --no-mouse --menu "$msg" 0 0 0 \
	startxfce4 "Xfce" fbterm "FbTerm" clear "bash" 2>$temp
[ $? -ne 0 ] && rm $temp && exit
tag=$(cat $temp)
rm $temp
case $tag in
	*) $tag;;
esac
