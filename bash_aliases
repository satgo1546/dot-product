# Coloured output for dir and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# A shortcut for listing all files
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias dirl='dir -alF'
alias dira='dir -A'
alias dircf='ls -CF'

# Alert
# Usage:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# fbterm with IME enabled
alias fbtim='fbterm -i fcitx-fbterm'
