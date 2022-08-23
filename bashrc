#===============================================================================
# ■ ~/.bashrc
#-------------------------------------------------------------------------------
#   Executed by bash(1) for non-login shells.
#===============================================================================

# If not running interactively, don't do anything.
[[ "$-" != *i* ]] && return

# Shell options and history control.
shopt -s cdspell cmdhist nocaseglob checkwinsize histappend globstar
shopt -u promptvars
HISTSIZE=30000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignoredups:ignorespace

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Be colorful.
[ "$TERM" = xterm ] && export TERM=xterm-256color
ESC=$'\x1b'
PROMPT_COMMAND=sats_ps1
PS2='  \[\e[0;32m\]┃\[\e[0m\] '
PS3="$ESC[0;32m──┨ $ESC[92m$ESC[0m "
PS4='. '
unset ESC
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_DESCRIBE_STYLE=default
GIT_PS1_HIDE_IF_PWD_IGNORED=1
sats_ps1() {
	PS1='\[\e[0;1;32;42m\] \u \[\e[0;7;32m\]│ !\! │'" $? "
	local -a list

	# What follows is adapted from git-prompt.sh.
	local b g p
	local step total short_sha repo_info inside_worktree repo_info bare_repo inside_gitdir
	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
		--is-bare-repository --is-inside-work-tree --short HEAD 2>/dev/null)"
	if [ "$?" = "0" ]
	then
		short_sha="${repo_info##*$'\n'}"
		repo_info="${repo_info%$'\n'*}"
	fi

	if [ -n "$repo_info" ]
	then
		p=""

		inside_worktree="${repo_info##*$'\n'}"
		repo_info="${repo_info%$'\n'*}"
		bare_repo="${repo_info##*$'\n'}"
		repo_info="${repo_info%$'\n'*}"
		inside_gitdir="${repo_info##*$'\n'}"
		# g is normally assigned ".git".
		g="${repo_info%$'\n'*}"
		if [ -d "$g/rebase-merge" ]
		then
			eread "$g/rebase-merge/head-name" b
			eread "$g/rebase-merge/msgnum" step
			eread "$g/rebase-merge/end" total
			p="rebasing "
		else
			if [ -d "$g/rebase-apply" ]
			then
				if [ -f "$g/rebase-apply/rebasing" ]
				then
					eread "$g/rebase-apply/head-name" b
					p="rebasing "
				elif [ -f "$g/rebase-apply/applying" ]
				then
					p="AM "
				else
					p="AM/rebasing "
				fi
				eread "$g/rebase-apply/next" step
				eread "$g/rebase-apply/last" total
			elif [ -f "$g/MERGE_HEAD" ]
			then
				p="merging "
			# see if a cherry-pick or revert is in progress, if the user has committed a
			# conflict resolution with 'git commit' in the middle of a sequence of picks or
			# reverts then CHERRY_PICK_HEAD/REVERT_HEAD will not exist so we have to read
			# the todo file.
			elif [ -f "$g/CHERRY_PICK_HEAD" ]
			then
				p="cherry-picking "
			elif test -f "$g/REVERT_HEAD"
			then
				p="reverting "
			elif eread "$g/sequencer/todo" todo
			then
				case "$todo" in
				p[\ \	]|pick[\ \	]*) p="cherry-picking " ;;
				revert[\ \	]*) p="reverting " ;;
				esac
			elif [ -f "$g/BISECT_LOG" ]
			then
				p="bisecting "
			fi
			[ -n "$p" ] && p="\[\e[1m\]$p"
			[ -z "$b" ] && b="$(
				git symbolic-ref --short HEAD 2>/dev/null \
				|| git describe --tags HEAD 2>/dev/null \
				|| echo $short_sha
			)"
			p="$p⎇ $b"
		fi
		[ -n "$total" ] && p="$p $step/$total"

		if [ "$inside_gitdir" = "true" ]
		then
			[ "$bare_repo" = "true" ] && p="bare: $p"
			[ "$bare_repo" = "true" ] || p="$p .git/"
		elif [ "$inside_worktree" = "true" ]
		then
			git diff --no-ext-diff --cached --quiet || p="$p+"
			git diff --no-ext-diff --quiet || p="$p*"
			[ -z "$short_sha" ] && p="$p #"
			# Find how many commits we are ahead/behind our upstream.
			upstream="$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)"
			if [ -n "$upstream" ]
			then
				left="${upstream%	*}"
				[ "$left" -ne 0 ] && p="$p $left<"
				right="${upstream#*	}"
				[ "$right" -ne 0 ] && p="$p $right>"
				[ "$left" -eq 0 ] && [ "$right" -eq 0 ] && p="$p ="
				p="$p $(git rev-parse --abbrev-ref @{upstream} 2>/dev/null)"
			fi
		fi
		[ "$(git config --bool core.sparseCheckout)" = "true" ] && p="$p sparse"
		list[${#list[@]}]="$p"
	fi

	#list[${#list[@]}]="?"

	if [ ${#list[@]} -eq 0 ]
	then
		PS1="$PS1│"
	else
		PS1="$PS1"'\[\e[0;32;107m\]▒ '"${list[0]}"'\[\e[0;32;107m\]'
		for ((i = 1; i < ${#list[@]}; i++))
		do
			PS1="$PS1 │ ${list[$i]}\[\e[0;32;107m\]"
		done
		PS1="$PS1"' ▒\[\e[0;7;32m\]'
	fi
	PS1="$PS1"' \W \[\e[0;92m\]\$⧖\[\e[0m\] '
	#PS1=⎐
}

# Aliases and functions.
alias ls="ls --color=auto"
alias la="ls -A"
alias ll="ls -lh"
alias dir="ls --color=auto --format=vertical"
alias md=mkdir
alias chdir=cd
alias df="df -h"
alias du="du -h"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias ack='ag --color-path="32" --color-match="4;33" --color-line-number="36"'
settitle() {
  echo -ne "\e]2;$@\a\e]1;$@\a"
}
x() {
	"$@" 1>/dev/zero 2>&1 &
}
alias dialog-hello='dialog --msgbox "Hello, world!" 6 24 # quite useless'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n 1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"
alias py='python -i -c "import os, sys, time, re, json, string, base64, struct, numpy as np, scipy, cv2, pandas as pd, matplotlib.pyplot as plt; from math import *; from typing import *; from numpy.typing import *"'
alias pytf='python -i -c "import numpy as np, tensorflow as tf; tf.sign(0)"'
tmproot() {
	if [ "x$1" = "x-" ]
	then
		docker start -i $(docker ps -ql)
	else
		mkdir -p /tmp/tmproot
		docker run -it --network host -v /tmp/tmproot-swapper:/swapper tensorflow/tensorflow /bin/sh -c \
			'sed -i "s/deb.debian.org/mirrors.ustc.edu.cn/g; s/security.debian.org/mirrors.ustc.edu.cn/g" /etc/apt/sources.list && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && apt-get update; exec bash'
	fi
}
fix-my-permissions() {
	chown -R $USER:$(id -gn) .
	find -type d -print0 | xargs -0 chmod 0775
	find -type f -print0 | xargs -0 chmod 0664
}
# Helper function to read the first line of a file into a variable.
# eread requires 2 arguments, the file path and the name of the variable, in that order.
eread() {
	[ -r "$1" ] && IFS=$'\r\n' read "$2" <"$1"
}
hash thefuck 2>/dev/null && eval $(thefuck --alias)

# Environment complex.
export EDITOR=vim
export VISUAL=vim
export SYSTEMD_PAGER=""
export PATH=$HOME/dot-product/scripts:$PATH:$HOME/.local/bin:$HOME/.cargo/bin
if false
then
	export XMODIFIERS=@im=ibus
	export GTK_IM_MODULE=ibus
	export QT_IM_MODULE=ibus
fi
if false
then
	# For Cygwin.
	export DISPLAY=:0.0
	export SDL_RENDER_DRIVER=software
fi
if true
then
	# For Windows Subsystem for Linux.
	#   sed -n "s/nameserver //p" /etc/resolv.conf
	export DISPLAY=$HOSTNAME.local:0
	export LIBGL_ALWAYS_INDIRECT=0
	export http_proxy=http://$HOSTNAME.local:7890
	# Setting https:// prevents curl from working, while wget is okay with it.
	export https_proxy=http://$HOSTNAME.local:7890
	alias clip="clip.exe"
	alias explorer="explorer.exe"
fi
if true
then
	export GDK_DPI_SCALE=1.5
	export QT_SCALE_FACTOR=1.5
fi
if true
then
	export GPG_TTY=$(tty)
fi
# It seems that a Windows Terminal bug prevents the first line of a colorful shell prompt from displaying correctly.
printf "\r"
