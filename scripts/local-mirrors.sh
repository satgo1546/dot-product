#!/bin/bash

root=/usr/share/nginx/html/mirrors/ajax/ajax/libs

print-help() {
	cat <<EOF
Examples:
# echo "http://cdn.bootcss.com/jquery/3.1.0/jquery.min.js" | local-mirrors.sh
That URL should be reachable by your network.
EOF
}

if [ "$1" = "--help" ]
then
	print-help
	exit
fi

while read url
do
	if [ -z "$url" ]
	then
		url=$(xclip -o -selection clipboard)
		echo "$url"
	fi
	path=$(echo "$url" | sed -r "s/^https?:\\/\\/[a-z.]+\\///")
	if [ "$path" = "$url" ]
	then
		echo "This isn't the URL I want."
		continue
	fi
	mkdir -p "$root/$(dirname $path)"
	curl -#o "$root/$path" $url
done
