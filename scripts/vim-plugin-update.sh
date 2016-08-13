#!/bin/bash
plugins=(
	tpope/vim-pathogen

	vim-airline/vim-airline
	easymotion/vim-easymotion
	terryma/vim-expand-region
	tpope/vim-fugitive
	tpope/vim-vinegar
	tpope/vim-characterize
	tpope/vim-speeddating
	tpope/vim-eunuch

	scrooloose/nerdcommenter
	Raimondi/delimitMate
	tomtom/tlib_vim
	MarcWeber/vim-addon-mw-utils
	garbas/vim-snipmate

	mattn/emmet-vim
	sukima/xmledit
	chrisbra/csv.vim
	kchmck/vim-coffee-script
)

print-help() {
	cat <<EOF
Examples:
$ vim-plugin-update.sh
$ vim-plugin-update.sh -i # no update (i.e. install new plugins only)
EOF
}

github-clone() {
	git clone --verbose --depth=1 --single-branch https://github.com/$1.git
}

OPTIND=1
while getopts "hi" opt
do
	case "$opt" in
		h) print-help; exit;;
		i) noupdate=1;;
	esac
done
[ "$noupdate" -eq 1 ] && echo "- noupdate == 1 -"

mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle
for p in ${plugins[@]}
do
	d=$(basename $p)
	echo -e "\e[34m$p ($d)\e[0m"
	if [ -d "$d" ]
	then
		[ "$noupdate" -eq 1 ] && continue
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
