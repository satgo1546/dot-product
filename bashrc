#===============================================================================
# ■ ~/.bashrc
#-------------------------------------------------------------------------------
#   Executed by bash(1) for non-login shells.
#===============================================================================

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines in the history
HISTCONTROL=ignoredups

# fix spelling mistakes automatically
shopt -s cdspell

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# be colorful
if [ "$TERM" = xterm ]
then
	export TERM=xterm-256color
fi
PS1='\[\033[0;1;32;42m\]${debian_chroot:+($debian_chroot)} \u \[\033[0;7;32m\]│ #\# │ $? │ \W \[\033[0;92m\]\$⧖\[\033[0m\] '
PS2='  \[\033[0;32m\]┃\[\033[0m\] '

# aliases
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
for ((i = 0; i < 256; i++))
do
	# Generate 0x100 aliases and this actually works!
	alias cdp$i="cd $HOME/repositories/project$i"
done

# $PATH
export PATH="$HOME/miscellaneous/scripts:$HOME/.gem/ruby/2.3.0/bin:$HOME/local/jdk1.8.0_65/bin:$PATH"

# IME and other miscellaneous stuff
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export SYSTEMD_PAGER=""

# completion.sh
source /usr/share/git/completion/git-completion.bash
