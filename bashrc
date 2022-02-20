#===============================================================================
# ■ ~/.bashrc
#-------------------------------------------------------------------------------
#   Executed by bash(1) for non-login shells.
#===============================================================================

# If not running interactively, don't do anything.
[[ "$-" != *i* ]] && return

# Shell options and history control.
shopt -s cdspell cmdhist nocaseglob checkwinsize histappend
HISTSIZE=30000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignoredups:ignorespace

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Be colorful.
[ "$TERM" = xterm ] && export TERM=xterm-256color
ESC=$(echo -e "\e")
PROMPT_COMMAND=sats_ps1
PS2='  \[\e[0;32m\]┃\[\e[0m\] '
PS3="$ESC[0;32m──┨ $ESC[92m$ESC[0m "
PS4='✢ '
unset ESC
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_DESCRIBE_STYLE=default
GIT_PS1_HIDE_IF_PWD_IGNORED=1

# Aliases and functions.
alias ls="ls --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias dir="ls"
alias dira="ls -A"
alias dirl="ls -l"
alias md=mkdir
alias chdir=cd
alias dialog-hello='dialog --msgbox "Hello, world!" 6 24 # quite useless'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n 1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"

# Environment variables.
export EDITOR=vim
export VISUAL=vim
export SYSTEMD_PAGER=""

source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh
source sats-ps1.sh
