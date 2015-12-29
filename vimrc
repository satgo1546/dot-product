"===============================================================================
" satgo's .vimrc

set nocompatible
filetype off

"-------------------------------------------------------------------------------
" pathogen.vim
execute pathogen#infect()

"-------------------------------------------------------------------------------
" evim
if v:progname =~? "evim"
	finish
endif

"-------------------------------------------------------------------------------
" Maximize the window
autocmd GUIEnter * silent !wmctrl
\ -r :ACTIVE: -b add,maximized_vert,maximized_horz

"-------------------------------------------------------------------------------
" These are from the .vimrc example by Bram Moolenaar

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
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
	set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
	\ wincmd p | diffthis
endif

"-------------------------------------------------------------------------------
" Configuration

" The location of dot-product repository
" No trailing slash is allowed here.
let g:dot_product_location = "$HOME/repositories/dot-product"

" How to pause
let g:pause_command = 'read -n 1 -p "……(.) "'

let g:rcnames = {
	\ "b": "bash",
	\ "v": "vim",
	\ "f": "fbterm",
\ }

"-------------------------------------------------------------------------------
" A set of 'set's (see :option)

" 2 moving around, searching and patterns
set incsearch
set smartcase

" 4 displaying text
set scrolloff=1
set wrap
set list
set listchars=tab:▏\ ,trail:·,extends:↩,precedes:↪
set fillchars=vert:\ ,fold:·,diff:·
set lazyredraw
set number
set norelativenumber
set numberwidth=6

" 5 syntax, highlighting and spelling
set background=light
set cursorline
set colorcolumn=80

" 6 multiple windows
set laststatus=2

" 7 multiple tab pages
set showtabline=2

" 9 using the mouse
if has('mouse')
	set mouse=a
endif
set nomousefocus
set nomousehide

" 10 GUI
set guifont=Monospace\ 14
set guioptions=aimgt

" 12 messages and info
set shortmess=l
set showcmd
set noshowmode
set ruler

" 13 selecting text
set clipboard=unnamed,autoselect

" 14 editing text
set backspace=indent,eol,start

" 15 tabs and indenting
set tabstop=2
set shiftwidth=2
set autoindent

" 16 folding
" I don't know why the following line doesn't work at all and outputs
" something weird like 'foldmethod=manual syntax=' in my terminal.
"set foldmethod syntax

" 18 mapping
set timeoutlen=1000
set ttimeoutlen=0

" 19 reading and writing files
" Since *~ files are annoying and I found has("vms") has no use, I turned this
" off. Maybe someday when I lose some file I'll turn this on back.
set nobackup

" 21 command line editing
set history=42
set wildmenu
set wildignore=*~

" Some highlights
" These usually aren't in color scheme files, so I include these here.
hi CursorLine              cterm=bold
hi CursorLineNr            cterm=bold
hi CursorColumn            cterm=bold
hi EasyMotionShade         cterm=bold ctermfg=0 gui=none guifg=#999999
hi EasyMotionTarget        cterm=bold ctermfg=3 gui=bold guifg=#ffb400
hi EasyMotionTarget2First  cterm=bold ctermfg=3 gui=bold guifg=#ffb400
hi EasyMotionTarget2Second cterm=none ctermfg=3 gui=none guifg=#b98300

"-------------------------------------------------------------------------------
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
let s:lang_configuration_prompt = v:lang =~# "^zh_CN\\." ?
\ "你想把当前文件复制到你的Git仓库中吗？" :
\ "Do you want to copy the current file to your Git repository?"
\ "取消提交操作。" : "Cancelled committing."

"-------------------------------------------------------------------------------
" Shortcuts

" I love <Space>!
let g:mapleader = "\<Space>"

" These are because a whitespace on the bottom-right corner can't be seen.
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
nmap <Leader><CR> :wq<CR>

" Clipboard
nmap <Leader>p "+p
nmap <Leader>P "+P
nmap <Leader>y "+y
vmap <Leader>y "+y

" Switching between windows
nmap <Leader>ww <C-w><C-w>
nmap <Leader>wh <C-w>h
nmap <Leader>wj <C-w>j
nmap <Leader>wk <C-w>k
nmap <Leader>wl <C-w>l
nmap <Leader>wt <C-w>t

" Switching between tabs
nmap <Leader><C-w> :tabclose<CR>
nmap <Leader><C-F4> :tabclose<CR>
nmap <Leader><C-t> :tabnew<CR>
nmap <Leader><Tab> :tabs<CR>
nmap <Leader><C-1> :tabfirst<CR>
nmap <Leader><C-2> :tabnext 2<CR>
nmap <Leader><C-3> :tabnext 3<CR>
nmap <Leader><C-4> :tabnext 4<CR>
nmap <Leader><C-5> :tabnext 5<CR>
nmap <Leader><C-6> :tabnext 6<CR>
nmap <Leader><C-7> :tabnext 7<CR>
nmap <Leader><C-8> :tabnext 8<CR>
nmap <Leader><C-9> :tablast<CR>

" Expand more
function! ExpandMore(filename)
	" Trim whitespace first
	let l:expanded = substitute(a:filename, "^\\s\\+\\|\\s\\+$", "", "g")
	if l:expanded == ""
		return ""
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
	elseif l:expanded =~? "^dir\\|^ls"
		" dir[ectory] or l[i]s[t]
		let l:expanded = "./"
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
nmap <Leader>e :call PromptForEditingFile("edit")<CR>
" s - Split horizontally
nmap <Leader>s :call PromptForEditingFile("split")<CR>
" v - Split vertically
nmap <Leader>v :call PromptForEditingFile("vsplit")<CR>
" t - Edit in a new tab
nmap <Leader>t :call PromptForEditingFile("tabnew")<CR>

" Changing current directory
nmap <Leader>c :call PromptForArg("cd", ":cd ", "dir")<CR>

" Making
nmap <Leader>m :!make -v<CR>
nmap <Leader>mk :wa<CR>:make<CR>
nmap <Leader>mf :call PromptForArg(":make", s:lang_argument_prompt, "file")<CR>
nmap <Leader>mc :make clean<CR>
nmap <Leader>me :e ./Makefile<CR>
nmap <Leader>ms :split ./Makefile<CR>
nmap <Leader>mv :vsplit ./Makefile<CR>
nmap <Leader>mt :tabnew ./Makefile<CR>

" Select the whole buffer
nmap <Leader>va ggVG

" Opening the terminal quickly
if has("gui_running")
	nmap <Leader>1 :!gnome-terminal --maximize &<CR><CR>
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
nmap <Leader>gl :!git fancync<CR>

" While I would like to keep this file on GitHub...
function! PromptForKeepingConfiguration()
	if input(s:lang_configuration_prompt) !=? "y"
		return
	endif
	let l:filename = expand("%:t")
	let l:target_filename = strpart(l:filename, 0, 1) != "." ?
	\ l:filename : strpart(l:filename, 1)
	execute printf(":!cp \"%s\" \"%s\"", expand("%"),
	\ g:dot_product_location . "/" . l:target_filename)
endfunction
autocmd BufWritePost ~/.{vim,bash,fbterm}rc,~/.bash_aliases call PromptForKeepingConfiguration()

" Running programs
function! RunProgram(prog, term)
	let l:command = ":!"
	" Disable a:term option when running without GUI
	if a:term && has("gui_running")
		let l:term = 1
	else
		let l:term = 0
	endif
	if l:term
		let l:command .= "gnome-terminal --maximize --command="
	endif
	" './' is needed to run a program directly
	if a:prog =~ "/"
		let l:prog = a:prog
	else
		let l:prog = "./" . a:prog
	endif
	let l:command .= shellescape(l:prog, l:term) . ";" . g:pause_command
	" Run in background
	if l:term
		let l:command .= "&"
	end
	execute l:command
endfunction
" The normal way: run programs in a terminal in the current directory
" Most of the mistakes can be prevented by saving all the files before running
" any files, so I added :wa here.
nmap <Leader>r :wa<CR>:call RunProgram(expand("%"), 1)<CR><CR>

"-------------------------------------------------------------------------------
" Plugins' world

" vim-airline
let g:airline_theme = "light"
if v:lang =~# "^zh_CN\\."
	let g:airline_mode_map = {
		\ "__": "——",
		\ "n" : "～",
		\ "i" : "插入",
		\ "R" : "替换",
		\ "c" : "命令",
		\ "v" : "可视",
		\ "V" : "可视 行",
		\ "": "可视 块",
		\ "s" : "选择",
		\ "S" : "选择 行",
		\ "": "选择 列",
	\ }
endif

" Emmet
autocmd FileType html,css imap <Tab> <Plug>(emmet-expand-abbr)

" delimitMate
let g:delimitMate_expand_cr = 2

" EasyMotion
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:EasyMotion_prompt = "{n} ⧖ "
map <Leader>j <Plug>(easymotion-prefix)
map / <Plug>(easymotion-sn)
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
