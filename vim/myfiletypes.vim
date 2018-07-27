function! EditMode_Project300Data()
	syntax match myNote /(\|\[\|{/
	syntax region myPY start=/(/ end=/)/
	syntax region myNote start=/\]\[/ end=/\]/
	syntax region myNote start=/}{/ end=/}/
	hi myNote font=FangSong:h16 guifg=#a6b727
	hi myPY guifg=#a6b727
	nmap <buffer> <F1> i[<Right>][]<Left>
	nmap <buffer> <F2> a()<Esc>:normal! i
	xmap <buffer> <F1> c[<C-r><C-r>"][]<Left>
	xmap <buffer> <F2> c{<C-r><C-r>"}{}<Left>
endfunction
nnoreme 20.15 编辑(&E).Project\ 300数据 :call EditMode_Project300Data()<CR>

function! EditMode_Project300Dictionary_Indent()
	if v:lnum == 1
		return 0
	endif
	if indent(v:lnum - 1) == 0
		return &tabstop
	endif
	return -1
endfunction

function! EditMode_Project300Dictionary()
	setlocal tabstop=8 shiftwidth=8 noexpandtab
	setlocal indentexpr=EditMode_Project300Dictionary_Indent()
	inoremap <buffer> <Tab> <Tab>
endfunction
nnoreme 20.15 编辑(&E).Project\ 300字典 :call EditMode_Project300Dictionary()<CR>
