"==============================================================================
" ■ satgo's .vimrc
"==============================================================================

" Initialization ----------------------------------------------------------{{{1

set nocompatible
set encoding=utf-8

syntax on
filetype plugin indent on

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
	\ wincmd p | diffthis
endif

"----------------------------------------------------------------------------
" Configuration for functions in this file

let g:commands = {}
if has("win32")
	let g:commands.pause = "pause"
	let g:commands.terminal = "cmd"
else
	let g:commands.pause = "read -n 1 -p '. . . '"
	let g:commands.terminal = "exo-open --launch TerminalEmulator &"
endif

" :option :set ------------------------------------------------------------{{{1

" 2 moving around, searching and patterns
set incsearch
set ignorecase smartcase

" 4 displaying text
set scrolloff=0
set wrap
set display=lastline,uhex
set list listchars=tab:»\ ,trail:·,extends:►,precedes:◄,nbsp:◦
set fillchars=stl:\ ,stlnc:\ ,vert:\ ,fold:┈,diff:-
set lazyredraw
set number norelativenumber
set numberwidth=6

" 5 syntax, highlighting and spelling
set background=light
set cursorline
set colorcolumn=80
if has("gui_running")
	" Everything looks terrible without a GUI
	colorscheme Tomorrow
endif
set hlsearch

" 6 multiple windows
set laststatus=2

" 7 multiple tab pages
set showtabline=2

" 8 terminal
set guicursor=a:block-blinkon0,ve:ver35,o:hor50,i-ci:ver20-blinkon0,r-cr:hor5

" 9 using the mouse
if has('mouse')
	set mouse=a
endif
set nomousefocus nomousehide

" 10 GUI
if has('gui_win32')
	set guifont=Courier_New:h14
	set guifontwide=NSimSun:h16
elseif has('gui_gtk2')
	set guifont=Monospace\ 14
endif
set guioptions=imglr
set linespace=2
set browsedir=current

" 12 messages and info
set shortmess=l
set showcmd
set noshowmode
set ruler
set errorbells

" 13 selecting text
set clipboard=unnamed

" 14 editing text
set undolevels=1024
set backspace=indent,eol,start
set matchpairs+=（:）,［:］,｛:｝,〔:〕,【:】,〖:〗,『:』,「:」,｢:｣
set nojoinspaces
set nrformats-=octal

" 15 tabs and indenting
set tabstop=2 shiftwidth=2
set noexpandtab
set autoindent

" 18 mapping
set timeoutlen=1000 ttimeoutlen=0

" 19 reading and writing files
" Since *~ files are annoying and I found has("vms") has no use, I turned this
" off. Maybe someday when I lose some file I'll turn this on back.
set nobackup
set autowrite

" 21 command line editing
set history=42
set wildmenu
set wildignore=*~,*.o,*.obj,*.bin,*.exe,*.png,*.jpg,*.gif,*.tif,*.tiff,*.tga
set wildignore+=*.pdf,*.dll,*.so,*.a,a.out,*.ttf,*.otf

" 22 executing external commands
set keywordprg= " set this by filetype

" 24 language specific
set isident+=@,$

" 25 multi-byte characters
set fileencodings=ucs-bom,utf-8,prc,ucs-2le,latin1
if has('win32')
	set termencoding=cp936
endif

" 26 various
set sessionoptions-=options,winpos,winsize

" Some highlights ---------------------------------------------------------{{{1
" These usually aren't in color scheme files, so I include these here.

hi CursorLine              cterm=none                         guibg=#fafafa
hi CursorLineNr            cterm=bold           gui=bold
hi CursorColumn            cterm=bold
hi VertSplit               cterm=none
hi clear Error
hi Error                   cterm=inverse        gui=undercurl guisp=red
hi SyntasticWarning        cterm=inverse        gui=undercurl guisp=DarkOrange
hi EasyMotionShade         cterm=none ctermfg=7 gui=none      guifg=gray60
hi EasyMotionTarget        cterm=none ctermfg=3 gui=bold      guifg=DarkGoldenrod1
hi EasyMotionTarget2First  cterm=none ctermfg=3 gui=bold      guifg=DarkGoldenrod1
hi EasyMotionTarget2Second cterm=none ctermfg=0 gui=none      guifg=DarkGoldenrod3
hi link SyntasticError Error

" Custom matches
match Error /\v^\s+$|\u037e/

" Translations ------------------------------------------------------------{{{1

let s:lang = {}
let s:langs = {}
let s:langs.code = ["^en", "\\v^zh_(CN|Hans)"]
let s:langs.prompt = ["%s: ", "%s："]
let s:langs.placeholder = ["<%s here>", "[键入%s]"]
let s:langs.filename = ["Filename", "文件名"]
let s:langs.argument = ["Argument", "参数"]
let s:langs.expired_space = [
	\ "<Space> expired at %s.",
	\ "<Space>已过期于%s。",
\ ]
let s:langs.missing_argument = [
	\ "Stopped executing because no arguments are specified.",
	\ "未输入参数，因此停止执行。",
\ ]
let s:langs.comment_head_exists = [
	\ "There's already a comment head.",
	\ "注释头已存在。",
\ ]
let s:langs.airline_mode_map = [
	\ {
		\ "__" : " - ",
		\ "n"  : " ~ ",
		\ "i"  : "INSERT",
		\ "R"  : "REPLACE",
		\ "v"  : "VISUAL",
		\ "V"  : "V-LINE",
		\ "c"  : "COMMAND",
		\ "" : "V-BLOCK",
		\ "s"  : "SELECT",
		\ "S"  : "S-LINE",
		\ "" : "S-BLOCK",
		\ "t"  : "TERMINAL",
	\ }, {
		\ "__": " － ",
		\ "n" : " ～ ",
		\ "i" : "插入",
		\ "R" : "替换",
		\ "c" : "命令",
		\ "v" : "可视",
		\ "V" : " 行 ",
		\ "": " 块 ",
		\ "s" : "选择",
		\ "S" : "‖行‖",
		\ "": "‖块‖",
		\ "t" : "终端",
	\ },
\ ]
let s:langs.airline_symbols = [
	\ {
		\ "paste": "PASTE",
		\ "spell": "SPELL",
		\ "readonly": "\ue0a2",
		\ "whitespace": "\u2739",
		\ "linenr": "\ue0a1",
		\ "maxlinenr": "\u2630",
		\ "branch": "\ue0a0",
		\ "notexists": "\u2204",
		\ "modified": "+",
		\ "space": " ",
		\ "crypt": "🔒",
	\ },
	\ {
		\ "paste": "粘贴",
		\ "spell": "拼写",
		\ "readonly": "\ue0a2",
		\ "whitespace": "\u2739",
		\ "linenr": "\ue0a1",
		\ "maxlinenr": "\u2630",
		\ "branch": "\ue0a0",
		\ "notexists": "\u2204",
		\ "modified": "已修改",
		\ "space": " ",
		\ "crypt": "🔒",
	\ },
\ ]

" Helper functions --------------------------------------------------------{{{1

function! InitializeLang()
	let l:lang_code = strpart(v:lang, 0, strridx(v:lang, ".") + 1)
	if l:lang_code == ""
		let l:lang_code = v:lang
	endif
	execute "language message " . l:lang_code . ".UTF-8"
	call InitializeLangScript()
	source $VIMRUNTIME/menu.vim
endfunction

function! InitializeLangScript()
	let l:lang_index = 0
	for l:regexp in s:langs.code
		if v:lang =~# l:regexp
			let s:lang.code = v:lang
			let s:lang.index = l:lang_index
			break
		endif
		let l:lang_index += 1
	endfor
	if l:lang_index >= len(s:langs.code)
		let s:lang.code = ""
		let s:lang.index = 0
		return
	endif
	for l:key in keys(s:langs)
		let s:lang[l:key] = s:langs[l:key][s:lang.index]
	endfor
endfunction
call InitializeLang()

function! ExpiredSpace()
	echo strftime(s:lang.expired_space)
endfunction

function! OpenTerminal()
	if has("gui_running")
		execute "silent !" . g:commands.terminal
	else
		shell
	endif
endfunction

function! NormalizeBuffer()
	let l:pos = getpos(".")
	%s/\s\+$//e
	nohlsearch
	call setpos(".", l:pos)
endfunction

function! CheckAndSetHelpWindow()
	if &filetype ==# "help"
		if &columns > 100
			wincmd H
			vertical resize 79
		else
			wincmd T
		endif
	endif
endfunction

function! GoToLastPosition()
	if line("'\"") > 1 && line("'\"") <= line("$") && expand("%:p:h:t") !=# ".git"
		normal! g`"
	endif
endfunction

" Keyboard mappings -------------------------------------------------------{{{1

let g:mapleader = "\<Space>"

noremap <Leader> :call ExpiredSpace()<CR>
inoremap <M-Space> <C-o>:call ExpiredSpace()<CR>

" Essentials
nnoremap <Leader><Leader> :w<CR>
nnoremap <Leader><BS> :nohlsearch<CR>
noremap Y y$
noremap j gj
noremap k gk

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y
vnoremap <Leader>Y "+Y

" Switching between windows
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Quick movement in insert mode
noremap! <A-h> <Left>
noremap! <A-j> <Down>
noremap! <A-k> <Up>
noremap! <A-l> <Right>

" Switching between tabs
nnoremap <C-1> :tabfirst<CR>
nnoremap <C-2> :tabnext 2<CR>
nnoremap <C-3> :tabnext 3<CR>
nnoremap <C-4> :tabnext 4<CR>
nnoremap <C-5> :tabnext 5<CR>
nnoremap <C-6> :tabnext 6<CR>
nnoremap <C-7> :tabnext 7<CR>
nnoremap <C-8> :tabnext 8<CR>
nnoremap <C-9> :tablast<CR>

" Inventory
" i - Edit .vimrc
nnoremap <Leader>i :tabnew $MYVIMRC<CR>
" e - Edit directly
nnoremap <Leader>e :edit<Space>
" s - Edit horizontally
nnoremap <Leader>s :new<Space>
" v - Edit vertically
nnoremap <Leader>v :vnew<Space>
" t - Edit in a new tab
nnoremap <Leader>t :tabnew<Space>
" d - Change working directory
nnoremap <Leader>d :cd<Space>
" a - Select the whole buffer
nnoremap <Leader>a ggVG
" q - Close buffer
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>Q :quit!<CR>
" j - EasyMotion
map <Leader>j <Plug>(easymotion-prefix)
" <C-s> - Show the active syntax highlighting groups under the cursor
nnoremap <Leader><C-s> :echo join(reverse(map(synstack(line("."), col(".")),
\ synIDattr(v:val, 'name')")), " ")<CR>

" Toolbar
noremap <F3> n
nnoremap <F5> :!run.sh<CR>
nnoremap <F7> :wa<CR>:make<CR>
nnoremap <S-F7> :make clean<CR>
nnoremap <F9> :call OpenTerminal()<CR>

" Various items dropped out

" Abbreviations -----------------------------------------------------------{{{1



" Not-so-magic Tab---------------------------------------------------------{{{1

function! TabInInsertMode()
	echo ""
	let l:pos = getpos(".")
	let l:line = getline(l:pos[1])
	let l:equal_column = strridx(l:line, "=") + 1
	if l:pos[1] == 1 && l:pos[2] == 1
		" Cursor there ↖
		if l:line =~# "=\\{77\\}$"
			echom s:lang.comment_head_exists
		else
			let l:buffer_name = expand("%")
			if l:buffer_name == ""
				let l:buffer_name = printf(s:lang.placeholder, s:lang.filename)
			endif
			" insert comment head
		endif
	elseif l:line =~# "^\\s\\{" . (l:pos[2] - 1) . "\\}"
		return "\<Tab>"
	elseif l:equal_column < l:pos[2]
	\ && l:line[(l:equal_column):(l:pos[2] - 1)] !~# "\\s"
		let l:expression = l:line[(l:equal_column - 1):(l:pos[2] - 2)]
		if l:pos[2] > len(l:line)
			normal! vF=d
		else
			normal! dF=
		endif
		echo l:expression
		return eval(l:expression[1:])
	else
		let l:word = snipMate#WordBelowCursor()
		let l:snippets = snipMate#GetSnippetsForWordBelowCursorForComplete(word)
		if len(l:snippets) > 1
			return snipMate#ShowAvailableSnips()
		elseif word !=# snippets[0]
			normal! "_db"_x
			return snippets[0]
		else
			return snipMate#TriggerSnippet(1)
		endif
	endif
	return ""
endfunction

map <Tab> <Plug>(easymotion-s)
map <C-Tab> <Plug>(easymotion-s2)
inoremap <Tab> <C-r>=TabInInsertMode()<CR>
imap <S-Tab> <Plug>delimitMateS-Tab
map <C-S-Tab> <Plug>(easymotion-sn)
map <C-A-S-Tab> <Plug>(easymotion-jumptoanywhere)
augroup sats_fttab
	autocmd!
	autocmd FileType html,css
	\ execute "imap <buffer> <Tab> <Plug>(emmet-expand-abbr)"
augroup END

" :autocmd groups ---------------------------------------------------------{{{1

augroup sats
	autocmd!
	autocmd GUIFailed * qall
	autocmd BufReadPost * call GoToLastPosition()
	autocmd BufWritePost * call NormalizeBuffer()
	autocmd FileType text setlocal textwidth=78
	autocmd FileType c,cpp setlocal keywordprg=man\ 3
	autocmd FileType sh setlocal keywordprg=man
	autocmd FileType vim setlocal foldmethod=marker keywordprg=
	autocmd FileType vim
	\ nnoremap <buffer> <F5> :execute "source " . expand("%")<CR>
	autocmd BufWinEnter * call CheckAndSetHelpWindow()
augroup END

" Plugins' world ----------------------------------------------------------{{{1

" vim-airline
let g:loaded_airline_themes = 1
let g:airline_theme = "sats"
let g:airline_mode_map = s:lang.airline_mode_map
let g:airline_symbols = s:lang.airline_symbols

" delimitMate
let g:delimitMate_quotes = "\" '"
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_excluded_regions = "String"

" SnipMate
let g:snips_author = "<subject name here>"
let g:snipMate = {}
let g:snipMate.no_match_completion_feedkeys_chars = ""

" EasyMotion
let g:EasyMotion_do_shade = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = "XYZWABCDUVEFGMNHPQRIJKLOST0123456789"
let g:EasyMotion_prompt = "{n} ⧖ "
let g:EasyMotion_inc_highlight = 0
let g:EasyMotion_verbose = 0

" Emmet
let g:user_emmet_install_global = 0

" NERD Commenter
" I can't remember such complex key mappings.
let g:NERDCreateDefaultMappings = 0
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" EOF }}}1
