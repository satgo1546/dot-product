#===============================================================================
# ■ ~/.bashrc
#-------------------------------------------------------------------------------
# Executed by bash(1) for non-login shells.
#===============================================================================

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines in the history
HISTCONTROL=ignoredups

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set colorful prompts
PS1='\[\033[0;1;36;46m\]${debian_chroot:+($debian_chroot)} \u \[\033[0;7;36m\]│ #\# │ $? │ \W \[\033[0;96m\]\$⧖\[\033[0m\] '
PS2='  \[\033[0;36m\]┃\[\033[0m\] '

# aliases
alias ls="ls --color=auto"
alias ll="dir -l"
alias dir="ls --color=auto"
alias dira="dir -A"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cmd="xfce4-terminal"

# $PATH
export PATH="$HOME/opt/cross/bin:$HOME/.gem/ruby/2.3.0/bin:$HOME/local/jdk1.8.0_65/bin:$PATH"
