#!/bin/bash
# kdialog --msgbox login
[ "$(date -d @$(stat -c %Y $HOME/.thunderbird/*.default-release) +%F)" == "$(date +%F)" ] || thunderbird &
python $HOME/dot-product/pystray/startup.py &
mkdir /run/user/1000/qq
mkdir /run/user/1000/qq/Pic
mkdir /run/user/1000/qq/Video
mkdir /run/user/1000/qq/Ptt
python $HOME/dot-product/scripts/login.py
