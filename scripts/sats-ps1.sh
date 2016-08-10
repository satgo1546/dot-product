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
	[ ${#list_compact[@]} -eq 0 ] && echo -n "│" && return
	echo -ne '\e[0;32;107m▒ '
	echo -n "${list_compact[0]}"
	for ((i = 1; i < ${#list_compact[@]}; i++))
	do
		echo -n " │ ${list_compact[$i]}"
	done
	echo -ne ' ▒\e[0;7;32m'
}
