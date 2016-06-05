#!/bin/bash
plugins=(
	vim-airline/vim-airline
	easymotion/vim-easymotion
	terryma/vim-expand-region
	tpope/vim-fugitive
	tpope/vim-vinegar

	scrooloose/nerdcommenter
	Raimondi/delimitMate
	tomtom/tlib_vim
	MarcWeber/vim-addon-mw-utils
	garbas/vim-snipmate
	scrooloose/syntastic

	mattn/emmet-vim
	sukima/xmledit
	skammer/vim-css-color
	kchmck/vim-coffee-script
)

print-help() {
	cat <<EOF
Examples:
$ noupdate=1 vim-plugin-update.sh
EOF
}

github-clone() {
	git clone --depth=1 https://github.com/$1.git
}

if [ "$1" = "--help" ]
then
	print-help
	exit
fi

mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle
for p in ${plugins[@]}
do
	d=$(basename $p)
	echo -e "\e[34m$p ($d)\e[0m"
	if [ -d "$d" ]
	then
		[ -n "$noupdate" ] && continue
		if [ -d "$d/.git" ]
		then
			cd $d
			git pull
			cd ..
		else
			rm -rfv "$d"
			github-clone $p
		fi
	else
		github-clone $p
	fi
done
