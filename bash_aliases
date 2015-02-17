# dir与grep的彩色输出
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls和dir的缩写
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias dirl='dir -alF'
alias dira='dir -A'
alias dircf='ls -CF'

# 为长时间运行的命令添加完成提示，用法如下：
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# fbterm with IME enabled
alias fbtim='fbterm -i fcitx_fbterm'
