set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showuntrackedfiles 0
set -g __fish_git_prompt_showupstream verbose name
set -g __fish_git_prompt_showcolorhints 0

function fish_prompt
	set -l last_status $status
	set -l duration $CMD_DURATION

	if [ $duration -ge 60000 ]
		set duration (math -s 0 $duration / 60000)ʹ(math -s 1 $duration % 60000 / 1000)ʺ
	else if [ $duration -ge 100 ]
		set duration (math -s 1 $duration / 1000)ʺ
	else
		set duration
	end

	my_prompt_line \
		([ $last_status -ne 0 ] && fish_status_to_signal $last_status) \
		$duration \
		"" \
		(fish_git_prompt "⎇ %s" 2>/dev/null) \
		(set -q VIRTUAL_ENV && echo -n "⚕ " && string replace -r '.*/' '' -- "$VIRTUAL_ENV") \
		"" \
		(prompt_pwd)
	if fish_is_root_user
		# Useful for e.g., `podman unshare`.
		set_color red
		echo -n "⧗ "
	else
		echo -n "⧖ "
	end
	set_color normal
end
