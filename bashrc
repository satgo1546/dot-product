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
sats_ps1() {
	PS1='\[\e[0;1;32;42m\] \u \[\e[0;7;32m\]│ !\! │ $? '
	sats_ps1_extra
	PS1="$PS1"' \W \[\e[0;92m\]\$⧖\[\e[0m\] '
}
sats_ps1_extra() {
	local i empty=0
	local list=(
		"$(__git_ps1 "⎇ %s")"
	)
	local -a list_compact
	for ((i = 0; i < ${#list[@]}; i++))
	do
		[ -n "${list[$i]}" ] && list_compact[${#list_compact[@]}]="${list[$i]}"
	done
	if [ ${#list_compact[@]} -eq 0 ]
	then
		PS1="$PS1│"
	else
		PS1="$PS1"'\[\e[0;32;107m\]▒ '"${list_compact[0]}"
		for ((i = 1; i < ${#list_compact[@]}; i++))
		do
			PS1="$PS1 │ ${list_compact[$i]}"
		done
		PS1="$PS1"' ▒\[\e[0;7;32m\]'
	fi
}

# Aliases and functions.
alias ls="ls --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias dir="ls --color=auto --format=vertical"
alias md=mkdir
alias chdir=cd
alias df="df -h"
alias du="du -h"
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias ack='ag --color-path="32" --color-match="4;33" --color-line-number="36"'
settitle() {
  echo -ne "\e]2;$@\a\e]1;$@\a";
}
alias dialog-hello='dialog --msgbox "Hello, world!" 6 24 # quite useless'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n 1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"

# Environment complex.
export EDITOR=vim
export VISUAL=vim
export SYSTEMD_PAGER=""
if false
then
	export XMODIFIERS=@im=ibus
	export GTK_IM_MODULE=ibus
	export QT_IM_MODULE=ibus
fi
if false
then
	source /usr/share/git/completion/git-completion.bash
	source /usr/share/git/completion/git-prompt.sh
fi
if false
then
	export DISPLAY=:0.0
	export SDL_RENDER_DRIVER=software
fi
