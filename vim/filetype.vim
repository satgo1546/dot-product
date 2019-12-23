function! EditMode_Project318Data()
	syntax match myNoteA /(/
	syntax match myNoteB /\[/
	syntax match myNoteC /{/
	syntax region myNoteA start=/(/ end=/)/
	syntax region myNoteB start=/\]\[/ end=/\]/
	syntax region myNoteC start=/}{/ end=/}/
	hi myNoteA guifg=#999999
	hi myNoteB font=FangSong:h16 guifg=#a6b727
	hi myNoteC font=KaiTi:h16 guifg=#e8ad46
	nmap <buffer> <F1> i[<Right>][]<Left>
	nmap <buffer> <F2> a()<Esc>:normal! i
	xmap <buffer> <F1> "zc[<C-r><C-r>z][]<Left>
	xmap <buffer> <F2> "zc{<C-r><C-r>z}{}<Left>
endfunction
nnoreme 20.15 编辑(&E).Project\ 318数据 :set filetype=p318data<CR>

function! EditMode_Project318Dict_Indent()
	if v:lnum == 1
		return 0
	endif
	if indent(v:lnum - 1) == 0
		return &tabstop
	endif
	return -1
endfunction

function! EditMode_Project318Dict()
	setlocal tabstop=8 shiftwidth=8 noexpandtab
	setlocal indentexpr=EditMode_Project318Dict_Indent()
	syntax match myStar /^\t\*/ms=s+1
	syntax match mySource /^\t\t《.*$/ms=s+2
	hi myStar guifg=#0a5d0a guibg=#deffd1
	hi mySource font=SimHei:h16 guifg=Gray
	inoremap <buffer> <Tab> <Tab>
	imap <buffer> 「 [
	imap <buffer> 【 [
	imap <buffer> 」 ]
	imap <buffer> 】 ]
endfunction
nnoreme 20.15 编辑(&E).Project\ 318字典 :set filetype=p318dict<CR>

augroup Sats_FileType
	autocmd!
  autocmd BufRead,BufNewFile *318/data/???-*.txt setfiletype p318data
	autocmd FileType p318data call EditMode_Project318Data()
  autocmd BufRead,BufNewFile *318/data/dictionary.txt setfiletype p318dict
	autocmd FileType p318dict call EditMode_Project318Dict()
augroup END
