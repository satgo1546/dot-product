"==============================================================================
" ■ functions.vim
"------------------------------------------------------------------------------
"   Use :function! instead of :function.
"==============================================================================

let g:slash = (&shellslash ? '/' : '\')

def! ExpiredSpace()
	echo strftime("%s")
enddef

def! Bell()
	execute "normal! \<Esc>"
enddef

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

function! FindCurrentColorScheme()
	return findfile(g:colors_name . ".vim", join(finddir("colors", &rtp, -1), ","))
endfunction

try
	function! Run()
		let command = ""
		if &filetype == "vim"
			let command = "source %"
		elseif &filetype == "dosbatch"
			let command = "!start " . expand("%:S")
		elseif &filetype == "ruby"
			let command = "!ruby " . expand("%:S")
		elseif &filetype == "python"
			let command = "!python " . expand("%:S")
		elseif &filetype == "make"
			let command = "!make"
		elseif &filetype == ""
		else
			let command = has('win32') ? "!run.bat" : "!run.sh"
		endif
		if has('win32') && command =~# "^!"
			"let command = strpart(command, 1)
			"let command = "silent !start cmd.exe /s /c (" . command . " ^& pause)"
		endif
		execute command
	endfunction
catch /^Vim\%((\a\+)\)\=:E127/
endtry

function! OpenTerminal()
	if has('win32')
		silent !start
	else
		!bash
	endif
endfunction

function! SeparateEvenOddLines()
	" There have to be an even number of lines
	if line("$") % 2
		$
		put =''
	endif
	global/^/+move$
endfunction

function! GetEncodedEscapeSequences(text, encoding)
	let str = iconv(a:text, "utf-8", a:encoding)
	let len = strlen(str)
	let i = 0
	let r = ""
	while i < len
		let charcodeupper = char2nr(str[i]) / 16
		let charcodelower = and(char2nr(str[i]), 15)
		let charupper = nr2char((charcodeupper > 9 ? 87 : 48) + charcodeupper)
		let charlower = nr2char((charcodelower > 9 ? 87 : 48) + charcodelower)
		let r .= "\\x" . charupper . charlower
		let i += 1
	endwhile
	return r
endfunction

function! InsertEncodedEscapeSequences(text, encoding)
	execute "normal! a" . GetEncodedEscapeSequences(a:text, a:encoding)
endfunction

function! EnterEncodedEscapeSequences(encoding)
	call InsertEncodedEscapeSequences(inputdialog("输入要编码的字符。"), a:encoding)
endfunction
