"==============================================================================
" ■ satgo's .vimrc
"==============================================================================

"----------------------------------------------------------------------------
" Initialization

set nocompatible
set guioptions=fimMglr

" Why to turn this off?
filetype off

execute pathogen#infect()

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif
	augroup END
else
	" always set autoindenting on
	set autoindent
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
	\ wincmd p | diffthis
endif

"----------------------------------------------------------------------------
" Configuration for functions in this file

let g:pause_command = 'read -n 1 -p "……(.) "'
let g:terminal = "xfce4-terminal"
let g:rcnames = {
	\ "b": "bash",
	\ "v": "vim",
	\ "f": "fbterm",
\ }

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
set background=light
set cursorline
set colorcolumn=80
if has("gui_running")
	" Everything looks terrible without a GUI
	colorscheme Tomorrow
endif

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
hi CursorLine              cterm=none                         guibg=#f9f9f9
hi CursorLineNr            cterm=bold           gui=bold
hi CursorColumn            cterm=bold
hi VertSplit               cterm=none
hi clear Error
hi Error                   cterm=inverse        gui=undercurl guisp=red
hi link SyntasticError Error
hi SyntasticWarning        cterm=inverse        gui=undercurl guisp=DarkOrange
hi EasyMotionShade         cterm=bold ctermfg=0 gui=none      guifg=gray60
hi EasyMotionTarget        cterm=bold ctermfg=3 gui=bold      guifg=DarkGoldenrod1
hi EasyMotionTarget2First  cterm=bold ctermfg=3 gui=bold      guifg=DarkGoldenrod1
hi EasyMotionTarget2Second cterm=none ctermfg=3 gui=none      guifg=DarkGoldenrod3

"----------------------------------------------------------------------------
" Translations
let s:lang_prompt = v:lang =~# "^zh_CN\\." ?
\ "%s：" : "%s: "
let s:lang_expired_space = v:lang =~# "^zh_CN\\." ?
\ "空格键已过期于 %s。" : "The space key expired at %s."
let s:lang_filename = v:lang =~# "^zh_CN\\." ?
\ "文件名" : "Filename"
let s:lang_argument = v:lang =~# "^zh_CN\\." ?
\ "参数" : "Argument"
let s:lang_commit_message = v:lang =~# "^zh_CN\\." ?
\ "提交信息" : "Commit message"
let s:lang_missing_argument = v:lang =~# "^zh_CN\\." ?
\ "未输入参数，因此停止执行。"
\ : "Stopped executing because no argument is specified."
let s:lang_filename_prompt = printf(s:lang_prompt, s:lang_filename)
let s:lang_argument_prompt = printf(s:lang_prompt, s:lang_argument)
let s:lang_commit_message_prompt = printf(s:lang_prompt, s:lang_commit_message)
let s:lang_stopped_committing = v:lang =~# "^zh_CN\\." ?
\ "取消提交操作。" : "Cancelled committing."

"----------------------------------------------------------------------------
" Shortcuts

let g:mapleader = "\<Space>"

function! ExpiredSpace()
	echo printf(s:lang_expired_space, strftime("%s"))
endfunction
nmap <Leader> :call ExpiredSpace()<CR>
imap <C-Space> <C-o>:call ExpiredSpace()<CR>

function! PromptForArg(command, prompt, completion)
	let l:arg = input(a:prompt, "", a:completion)
	if l:arg == ""
		echo s:lang_missing_argument
		return
	endif
	execute a:command . " " . l:arg
endfunction

" Essentials
nmap <Leader><Leader> :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader><S-q> :q!<CR>
nmap <Leader><BS> :nohlsearch<CR>
nmap <C-CR> :wq<CR>
map Y y$

" Clipboard
nmap <Leader>p "+p
nmap <Leader>P "+P
nmap <Leader>y "+y
vmap <Leader>y "+y

" Switching between windows
nmap <A-h> <C-w>h
nmap <A-j> <C-w>j
nmap <A-k> <C-w>k
nmap <A-l> <C-w>l

" Quick movement in insert mode
imap <A-h> <Left>
imap <A-j> <Down>
imap <A-k> <Up>
imap <A-l> <Right>

" Switching between tabs
nmap <A-w> :tabclose<CR>
nmap <Leader><Tab> :tabs<CR>
nmap <A-1> :tabfirst<CR>
nmap <A-2> :tabnext 2<CR>
nmap <A-3> :tabnext 3<CR>
nmap <A-4> :tabnext 4<CR>
nmap <A-5> :tabnext 5<CR>
nmap <A-6> :tabnext 6<CR>
nmap <A-7> :tabnext 7<CR>
nmap <A-8> :tabnext 8<CR>
nmap <A-9> :tablast<CR>

" Expand more
function! ExpandMore(filename)
	" Trim whitespace first
	let l:expanded = substitute(a:filename, "^\\s\\+\\|\\s\\+$", "", "g")
	if l:expanded == ""
		return ""
	elseif l:expanded =~? "^\\(mkf\\|makefile\\)$"
		return "Makefile"
	elseif l:expanded =~? "^\\.\\=.*rc$"
		" This removes the dot and 'rc'
		let l:rcname = strpart(l:expanded, strpart(l:expanded, 0, 1) == ".",
		\ strlen(l:expanded) - 2)
		" Expand shortcuts
		if has_key(g:rcnames, l:rcname)
			let l:rcname = g:rcnames[l:rcname]
		endif
		if l:rcname ==? "vim"
			let l:expanded = "$MYVIMRC"
		else
			let l:expanded = "~/." . l:rcname . "rc"
		endif
	endif
	return expand(l:expanded)
endfunction

" Edit files
" a:command can be "e", "tabe", etc.
function! PromptForEditingFile(command)
	let l:filename = input(":" . a:command . " ", "", "file")
	echo ""
	execute a:command . " " . ExpandMore(l:filename)
endfunction

" e - Edit directly
nmap <Leader>e :edit<Space>
" s - Split horizontally
nmap <Leader>s :split<Space>
" v - Split vertically
nmap <Leader>v :vsplit<Space>
" t - Edit in a new tab
nmap <Leader>t :tabnew<Space>

" Changing current directory
nmap <Leader>d :call PromptForArg("cd", ":cd ", "dir")<CR>

" Making
nmap <Leader>m :!make -v<CR>
nmap <Leader>mk :wa<CR>:make<CR>
nmap <Leader>mf :call PromptForArg(":make", s:lang_argument_prompt, "file")<CR>
nmap <Leader>mc :make clean<CR>

" Select the whole buffer
nmap <Leader>a ggVG

" Open the terminal
if has("gui_running")
	execute "nmap <Leader>1 :!" . g:terminal . " --maximize &<CR><CR>"
else
	nmap <Leader>1 :shell<CR>
endif

" The Crafting Guide Git
function! GitCommit(message, all)
	if a:message == ""
		let l:message = input(s:lang_commit_message_prompt)
		if l:message == ""
			echo s:lang_stopped_committing
			return
		endif
	else
		let l:message = a:message
	endif
	let l:cmd = ":!git commit -"
	if a:all
		let l:cmd .= "a"
	endif
	let l:cmd .= "m \"" . l:message . "\""
	execute l:cmd
endfunction

nmap <Leader>g :!git --version<CR>
nmap <Leader>gs :!git status<CR>
nmap <Leader>gaa :!git add -A<CR>
nmap <Leader>gaA :!git add -A :/<CR>
nmap <Leader>gcs :call GitCommit("", 0)<CR>
nmap <Leader>gca :call GitCommit("", 1)<CR>
nmap <Leader>gl :!git graph<CR>

" Running programs
function! MakeRun()
	wa
	let l:command = ":!false"
	let l:command .= "|| ./run.sh " . shellescape(expand("%"), 1)
	let l:command .= "|| make run"
	"let l:command .= "|| " . g:terminal . " --hide-menubar --geometry 80x25"
	let l:command .= "|| cd .. && make run"
	execute l:command
endfunction

nmap <F5> :call MakeRun()<CR>

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

" Emmet
autocmd FileType html,css imap <buffer> <Tab> <Plug>(emmet-expand-abbr)

" delimitMate
let g:delimitMate_expand_cr = 2

" EasyMotion
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
let g:EasyMotion_prompt = "{n} ⧖ "
map <Leader>j <Plug>(easymotion-prefix)
map <Tab> <Plug>(easymotion-s)
map <S-Tab> <Plug>(easymotion-s2)

" NERD Commenter
" I can't remember such complex key mappings.
let g:NERDCreateDefaultMappings = 0
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" vim-css-color
let g:cssColorVimDoNotMessMyUpdatetime = 1

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 0
