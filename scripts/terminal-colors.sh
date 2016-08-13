#!/bin/bash
echo -e "\e[0mBG= 0 1 2 3 4 5 6 7\e[1m 0 1 2 3 4 5 6 7\e[0m"
for ((fg = 0; fg < 16; fg++))
do
	printf "%02d " $fg
	for ((bg = 0; bg < 16; bg++))
	do
		code='\e['
		[ $fg -ge 8 ] && code="${code}1;3$((fg - 8))" || code="${code}3$fg"
		[ $bg -ge 8 ] && code="${code};10$((bg - 8))" || code="${code};4$bg"
		echo -ne "${code}mAa"
	done
	echo -e "\e[0m"
done
