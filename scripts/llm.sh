#!/bin/bash
set -e
request=$(jq --raw-input --slurp --arg prefix "$1" --arg suffix "$2" '{
	model: "deepseek-flash",
	messages: [
		{role: "user", content: .},
		if $prefix != "" then {role: "assistant", prefix: true, content: $prefix} else empty end
	],
	thinking: {type: "disabled"},
	stop: if $suffix != "" then [$suffix] else empty end,
	stream: true,
	temperature: 0,
	top_p: 3e-45,
}')
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H "Authorization: Bearer $OPENAI_API_KEY" --data "$request" --no-progress-meter https://api.deepseek.com/beta/chat/completions | sed -E 's/^data: ?(\[DONE\])?//' | jq --join-output '.choices[0].delta.content'
