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
