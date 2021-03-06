#!/bin/bash

swapper="/media/swapper"
cmd=rsync
cmd="$cmd --recursive --update --times --human-readable --del --executability"
cmd="$cmd --progress --verbose"
me=$(basename $0)
d=$(basename $(pwd))

case $1 in
	--help | -h | -? )
		cat <<EOF
$ $me <--help|-h|-?>
Examples:
$ $me get # SWAPPER -> .
$ $me put # . -> SWAPPER
EOF
		;;
	get | put)
		if [ $1 = "get" ]
		then
			$cmd "$swapper/$d/" "./"
			[ -d .git ] && git config --local core.fileMode true
		else
			[ -d .git ] && git config --local core.fileMode false
			$cmd "./" "$swapper/$d/"
			[ -d .git ] && git config --local core.fileMode true
		fi
		;;
	* )
		echo "$me <--help|-h|-?>" >&2
		echo "$me <get|put>" >&2
		;;
esac
