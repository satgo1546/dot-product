"==============================================================================
" ■ functions.vim
"------------------------------------------------------------------------------
"   Use :function! instead of :function.
"==============================================================================

let g:slash = (&shellslash ? '/' : '\')

function! ExpiredSpace()
	echo strftime("%s")
endfunction

function! Bell()
	execute "normal! \<Esc>"
endfunction

function! NormalizeBuffer()
	let l:pos = getpos(".")
	keeppatterns %s/\s\+$//e
	nohlsearch
	call setpos(".", l:pos)
endfunction

function! CheckAndSetHelpWindow()
	if &filetype == "help"
		if &columns > 100
			wincmd H
			vertical resize 79
		else
			silent wincmd T
		endif
	endif
endfunction

function! GoToLastPosition()
	if expand("%:p:h:t") ==# ".git"
		return
	endif
	if line("'\"") > 1 && line("'\"") <= line("$")
		normal! g`"
	endif
endfunction

function! EchoSynStack()
	echo join(reverse(map(synstack(line("."), col(".")), 'synIDattr(v:val, "name")')), " ")
endfunction

function! FileFormat() " taken from menu.vim
	if !exists("g:menutrans_fileformat_dialog")
		let g:menutrans_fileformat_dialog = "Select format for writing the file"
	endif
	if !exists("g:menutrans_fileformat_choices")
		let g:menutrans_fileformat_choices = "&Unix\n&Dos\n&Mac\n&Cancel"
	endif
	let def = (&ff == "dos" ? 2 : (&ff == "mac" ? 3 : 1))
	let n = confirm(g:menutrans_fileformat_dialog, g:menutrans_fileformat_choices, def, "Question")
	if n < 4
		let &ff = (n == 1 ? "unix" : (n == 2 ? "dos" : "mac"))
	endif
endfunction

" xxd ---------------------------------------------------------------------{{{1
if !exists("g:xxdprogram")
	if has("win32") && !executable("xxd")
		let g:xxdprogram = $VIMRUNTIME . g:slash . "xxd.exe"
	else
		let g:xxdprogram = "xxd"
	endif
endif

function! XxdConv()
	let mod = &mod
	execute '%!"' . g:xxdprogram . '"'
	if getline(1) =~ "^0000000:"
		set ft=xxd
	endif
	let &mod = mod
endfunction

function! XxdBack()
	let mod = &mod
	execute '%!"' . g:xxdprogram . '" -r'
	set ft=
	doautocmd filetypedetect BufReadPost
	let &mod = mod
endfunction
" -------------------------------------------------------------------------}}}1

function! ShowWordCount()
	let h = wordcount()
	echomsg "字符数 = " . h.chars . "; 单词数 = " . h.words
endfunction

function! FindNext(delta) range
	try
		if a:delta > 0
			execute "normal! " . a:delta . "n"
		elseif a:delta < 0
			execute "normal! " . abs(a:delta) . "N"
		endif
	catch /^Vim\%((\a\+)\)\=:E486/
		echohl ErrorMsg
		echomsg "找不到模式"
		call Bell()
		echohl None
	finally
		set hlsearch
	endtry
endfunction

function! ClearHighlight()
	nohlsearch
	set nohlsearch
endfunction

function! FindCurrentColorScheme()
	return findfile(g:colors_name . ".vim", join(finddir("colors", &rtp, -1), ","))
endfunction

try
	function! Run()
		if &filetype == "vim"
			source %
		elseif &filetype == "dosbatch"
			execute "!start " . expand("%:S")
		else
			if has('win32')
				!run.bat
			else
				!run.sh
			endif
		endif
	endfunction
catch /^Vim\%((\a\+)\)\=:E127/
endtry

function! SeparateEvenOddLines()
	" There have to be an even number of lines
	if line("$") % 2
		$
		put =''
	endif
	global/^/+move$
endfunction
