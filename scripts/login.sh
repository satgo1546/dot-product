#!/bin/bash
# kdialog --msgbox login
[ "$(date -d @$(stat -c %Y $HOME/.thunderbird/*.default-release) +%F)" == "$(date +%F)" ] || thunderbird &
