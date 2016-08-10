#===============================================================================
# ■ ~/.bashrc
#-------------------------------------------------------------------------------
#   Executed by bash(1) for non-login shells.
#===============================================================================

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# shell options and history control
shopt -s cdspell cmdhist nocaseglob checkwinsize histappend
HISTSIZE=30000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignoredups:ignorespace

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# be colorful
[ "$TERM" = xterm ] && export TERM=xterm-256color
ESC=$(echo -e "\e")
PS1='\[\e[0;1;32;42m\] \u \[\e[0;7;32m\]│ #\# │ $? │ \W \[\e[0;92m\]\$⧖\[\e[0m\] '
PS2='  \[\e[0;32m\]┃\[\e[0m\] '
PS3="$ESC[0;32m──┨ $ESC[92m$ESC[0m "
PS4='✢ '

# aliases and functions
alias ls="ls --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias dir="ls"
alias dira="ls -A"
alias dirl="ls -l"
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias mx="chmod +x"
alias dialog-hello='dialog --msgbox "Hello, world!" 6 24 # quite useless'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n 1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"
cdp() {
	cd $HOME/repositories/project$1
}

# $EDITOR; here comes a battle
export EDITOR=vim
export VISUAL=vim

# $PATH
PATH="$HOME/.gem/ruby/2.3.0/bin:$PATH"
PATH="$HOME/local/jdk1.8.0_65/bin:$PATH"
PATH="$HOME/local/AFDKO/Tools/linux:$PATH"
PATH="$HOME/miscellaneous/scripts:$PATH"
export PATH

# IME and other miscellaneous stuff
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export SYSTEMD_PAGER=""

# completion.sh
source /usr/share/git/completion/git-completion.bash
