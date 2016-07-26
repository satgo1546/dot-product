#!/bin/bash
temp=$(mktemp)
dialog --backtitle "$0: \$USER = $USER" --title "login-menu.sh" \
	--no-ok --no-cancel --no-mouse --menu "$" 0 0 0 \
	startxfce4 "Xfce" fbterm "FbTerm" clear "bash" 2>$temp
[ $? -ne 0 ] && rm $temp && exit
tag=$(cat $temp)
rm $temp
case $tag in
	*) $tag;;
esac
