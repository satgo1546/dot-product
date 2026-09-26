status is-interactive || return
set fish_color_command blue
bind ctrl-h backward-kill-token
bind ctrl-i fish-inline-chat
abbr --add cd. cd .
abbr --add cd.. cd ..
set -gx VIRTUAL_ENV_DISABLE_PROMPT true
function auto_env --description 'Auto activate/deactivate virtualenv when I change directories' --on-variable PWD
	if set -q VIRTUAL_ENV
	else
		if test -d .venv -a ! -e uv.lock
			source .venv/bin/activate.fish
		else if test -d venv
			source venv/bin/activate.fish
		end
	end
end
auto_env
set -gx FZF_DEFAULT_COMMAND 'fd --type file'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
fzf --fish | source
function at_exit_disown_jobs --on-event fish_postexec
	if jobs -q
		disown $(jobs -p)
	end
end
