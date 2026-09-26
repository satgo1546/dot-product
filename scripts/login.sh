#!/bin/bash
# kdialog --msgbox login
[ "$(date -d @$(stat -c %Y $HOME/.thunderbird/*.default-release) +%F)" == "$(date +%F)" ] || thunderbird &
python $HOME/dot-product/pystray/startup.py &
python $HOME/dot-product/ahk/unicode_palette_pyqt6.py &
mkdir -p /run/user/1000/qq/{Pic,Video,Ptt}
python $HOME/dot-product/scripts/login.py
