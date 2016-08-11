"==============================================================================
" ■ satgo's .vimrc
"==============================================================================

"----------------------------------------------------------------------------
" Initialization

set nocompatible
set guioptions=fimMglr

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
	\ wincmd p | diffthis
endif

"----------------------------------------------------------------------------
" Configuration for functions in this file

if has("win32")
	let g:pause_command = "pause"
	let g:terminal = "cmd"
else
	let g:pause_command = "read -n 1 -p '. . . '"
	let g:terminal = "exo-open --launch TerminalEmulator"
endif

"----------------------------------------------------------------------------
" :option

" 2 moving around, searching and patterns
set incsearch
set smartcase

" 4 displaying text
set scrolloff=0
set wrap
set list listchars=tab:»\ ,trail:·,extends:►,precedes:◄,nbsp:◦
set fillchars=stl:\ ,stlnc:\ ,vert:\ ,fold:┈,diff:-
set lazyredraw
set number norelativenumber
set numberwidth=6

" 5 syntax, highlighting and spelling
syntax on
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
" 'guioptions' has been set before.
set guifont=Monospace\ 14
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
set backspace=indent,eol,start

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
set wildmenu wildignore=*~,*.o,*.obj,*.bin,*.exe

" Some highlights
" These usually aren't in color scheme files, so I include these here.
hi CursorLine              cterm=none                         guibg=#fafafa
hi CursorLineNr            cterm=bold           gui=bold
hi CursorColumn            cterm=bold
hi VertSplit               cterm=none
hi clear Error
hi Error                   cterm=inverse        gui=undercurl guisp=red
hi SyntasticWarning        cterm=inverse        gui=undercurl guisp=DarkOrange
hi EasyMotionShade         cterm=bold ctermfg=0 gui=none      guifg=gray60
hi EasyMotionTarget        cterm=bold ctermfg=3 gui=bold      guifg=DarkGoldenrod1
hi EasyMotionTarget2First  cterm=bold ctermfg=3 gui=bold      guifg=DarkGoldenrod1
hi EasyMotionTarget2Second cterm=none ctermfg=3 gui=none      guifg=DarkGoldenrod3
hi link SyntasticError Error

" Custom matches
match Error /^\s\+$/

"----------------------------------------------------------------------------
" Translations

let s:lang = {}
let s:langs = {}
let s:langs.code = ["^en", "\\v^zh_(CN|Hans)\\."]
let s:langs.prompt = ["%s: ", "%s："]
let s:langs.placeholder = ["<%s here>", "[键入%s]"]
let s:langs.filename = ["Filename", "文件名"]
let s:langs.argument = ["Argument", "参数"]
let s:langs.expired_space = [
	\ "<Space> expired at %d.",
	\ "<Space>已过期于%d。",
\ ]
let s:langs.missing_argument = [
	\ "Stopped executing because no arguments are specified.",
	\ "未输入参数，因此停止执行。",
\ ]
let s:langs.comment_head_exists = [
	\ "There's already a comment head.",
	\ "注释头已存在。",
\ ]

"----------------------------------------------------------------------------
" Helper functions

function! InitializeLang()
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
	endif
	for l:key in keys(s:langs)
		let s:lang[l:key] = s:langs[l:key][s:lang.index]
	endfor
endfunction
call InitializeLang()

function! ExpiredSpace()
	echo printf(s:lang_expired_space, strftime("%s"))
endfunction

function! OpenTerminal()
	if has("gui_running")
		!exo-open --launch TerminalEmulator &<CR><CR>
	else
		shell
	endif
endfunction

function! NormalizeBuffer()
	let l:pos = getpos(".")
	silent! %s/\s\+$//
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

"----------------------------------------------------------------------------
" Keyboard mappings

let g:mapleader = "\<Space>"

noremap <Leader> :call ExpiredSpace()<CR>
inoremap <M-Space> <C-o>:call ExpiredSpace()<CR>

" Essentials
nnoremap <Leader><Leader> :w<CR>
nnoremap <Leader><BS> :nohlsearch<CR>
noremap Y y$

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
nnoremap <A-1> :tabfirst<CR>
nnoremap <A-2> :tabnext 2<CR>
nnoremap <A-3> :tabnext 3<CR>
nnoremap <A-4> :tabnext 4<CR>
nnoremap <A-5> :tabnext 5<CR>
nnoremap <A-6> :tabnext 6<CR>
nnoremap <A-7> :tabnext 7<CR>
nnoremap <A-8> :tabnext 8<CR>
nnoremap <A-9> :tablast<CR>

" Inventory
" i - Edit my .vimrc
nnoremap <Leader>i :tabnew $MYVIMRC<CR>
" e - Edit directly
nnoremap <Leader>e :edit<Space>
" s - Split horizontally
nnoremap <Leader>s :split<Space>
" v - Split vertically
nnoremap <Leader>v :vsplit<Space>
" t - Edit in a new tab
nnoremap <Leader>t :tabnew<Space>
" d - Change working directory
nnoremap <Leader>d :cd<Space>
" a - Select the whole buffer
nnoremap <Leader>a ggVG
" q - Close buffer
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>
" j - EasyMotion
map <Leader>j <Plug>(easymotion-prefix)

" Toolbar
noremap <F3> n
nnoremap <F5> :!run.sh<CR>
nnoremap <F7> :wa<CR>:make<CR>
nnoremap <S-F7> :make clean<CR>
nnoremap <F9> :call OpenTerminal()<CR>

"----------------------------------------------------------------------------
" Abbreviations



"----------------------------------------------------------------------------
" Magic tab

function! TabInInsertMode()
	let l:pos = getpos(".")
	let l:line = getline(l:pos[1])
	let l:equal_column = strridx(l:line, "=") + 1
	if l:pos[1] == 1 && l:pos[2] == 1
		" Cursor there ↖
		if l:line =~# "=\\{77\\}$"
			echom s:lang_comment_head_exists
		else
			let l:buffer_name = expand("%")
			if l:buffer_name == ""
				let l:buffer_name = printf(s:lang.placeholder, s:lang.filename)
			endif
			" insert comment head
		endif
	elseif l:line =~# "^\\s\\{" . (l:pos[2] - 1) . "\\}"
		" only spacing characters before cursor
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
		silent! execute "return " . l:expression[1:]
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
	autocmd FileType html,css imap <buffer> <Tab> <Plug>(emmet-expand-abbr)
augroup END

"----------------------------------------------------------------------------
" autocmd groups

augroup vimrcEx
	autocmd!
	autocmd FileType text setlocal textwidth=78

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.
	autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup sats
	autocmd!
	autocmd BufWritePost * call NormalizeBuffer()
augroup END

augroup sats_window
	autocmd!
	autocmd BufWinEnter * call CheckAndSetHelpWindow()
augroup END

"----------------------------------------------------------------------------
" Plugins' world

" vim-airline
let g:loaded_airline_themes = 1
let g:airline_theme = "sats"
if v:lang =~# "^zh_CN\\."
	let g:airline_mode_map = {
		\ "__": " － ",
		\ "n" : " ～ ",
		\ "i" : "插入",
		\ "R" : "替换",
		\ "c" : "命令",
		\ "v" : "可视",
		\ "V" : "(行)",
		\ "": "(块)",
		\ "s" : "选择",
		\ "S" : "(行)",
		\ "": "(块)",
	\ }
endif
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" delimitMate
let g:delimitMate_matchpairs = "(:),[:],{:}"
let g:delimitMate_matchpairs .= ",（:）,［:］,｛:｝,〔:〕"
let g:delimitMate_matchpairs .= ",【:】,〖:〗,『:』,「:」,｢:｣"
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
