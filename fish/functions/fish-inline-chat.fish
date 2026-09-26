function fish-inline-chat
	set -qg __reading_fish_inline_chat && return
	set -l commandline $(commandline)
	test -n "$commandline" && echo && echo "$commandline"
	set -g __reading_fish_inline_chat 1
	read --prompt-str "$(set_color blue)🐳▽ $(set_color normal)" -l prompt
	set -eg __reading_fish_inline_chat
	if test -n "$prompt"
		echo -n "Thinking..." >&2
		set -l output $(printf "%s\n%s" "$commandline" "$prompt" | llm "```sh" "```")
		printf '\r\x1b[K' >&2
		commandline -r -- "$output"
		commandline -f repaint end-of-buffer
	else
		printf '\x1b[A' >&2
		commandline -f repaint
	end
end
