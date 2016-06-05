#!/bin/bash

swapper="/media/swapper"
cmd="rsync -vruth"
me=`basename $0`
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
		else
			$cmd "./" "$swapper/$d/"
		fi
		;;
	* )
		echo "$me <--help|-h|-?>" >&2
		echo "$me <get|put>" >&2
		;;
esac
