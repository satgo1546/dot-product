"==============================================================================
" ■ menu.vim
"------------------------------------------------------------------------------
"   Use :noreme instead of :an.
"==============================================================================

noreme 10.9999 文件(&F).退出(&X) :qa<CR>
noreme 20.10 编辑(&E).十六进制编辑(&C) :call XxdConv()<CR>
noreme 20.10 编辑(&E).十六进制编辑返回(&R) :call XxdBack()<CR>
noreme 20.20 编辑(&E).大幅改动(&B).删除空格(&S) :%s/ //g<CR>
noreme 20.20 编辑(&E).大幅改动(&B).删除空白(&W) :%s/\s+//g<CR>
let s:names = sort(map(split(globpath(&runtimepath, "colors/*.vim"), "\n"), 'substitute(v:val, "\\c.*[/\\\\:\\]]\\([^/\\\\:]*\\)\\.vim", "\\1", "")'), 1)
let s:i = 1
for s:name in s:names
	execute "noreme 40.10.40." . s:i . " 工具(&T).&Vim.色彩方案(&C)." . s:name . " :colorscheme " . s:name . "<CR>"
	let s:i += 1
endfor
unlet s:i s:name s:names
noreme 40.10.50 工具(&T).&Vim.显示语法栈(&S) :call EchoSynStack()<CR>
noreme 40.10.60 工具(&T).&Vim.色彩测试(&L) :tabnew $VIMRUNTIME/syntax/colortest.vim<Bar>so %<CR>
noreme 40.10.70 工具(&T).&Vim.高亮测试(&H) :runtime syntax/hitest.vim<CR>
noreme 40.20 工具(&T).转换为HTML(&C) :runtime syntax/2html.vim<CR>
noreme 40.50 工具(&T).-1- <Nop>
noreme 40.51 工具(&T).字数统计(&&)<Tab>g<C-g> :call ShowWordCount()<CR>
noreme 40.89 工具(&T).-2- <Nop>
noreme 40.90 工具(&T).编辑色彩方案(&C)
\ :execute "tabedit " . FindCurrentColorScheme()<CR>
noreme 40.91 工具(&T).编辑函数(&F)
\ :execute "tabedit " . findfile("functions.vim", &rtp)<CR>
noreme 40.92 工具(&T).编辑菜单(&M)
\ :execute "tabedit " . findfile("mymenu.vim", &rtp)<CR>
noreme 40.93 工具(&T).编辑行(&L)
\ :execute "tabedit " . findfile("line.vim", &rtp)<CR>
noreme 40.99 工具(&T).选项(&O)
\ :execute "tabedit " . findfile("vimrc", &rtp)<CR>
noreme 9999.10 帮助(&?).纵览(&O) :help<CR>
noreme 9999.11 帮助(&?).如何(&H) :help how-to<CR>
noreme 9999.15 帮助(&?).-1- <Nop>
noreme 9999.20 帮助(&?).笑着活下去(&S) :smile<CR>
noreme 9999.75 帮助(&?).-2- <Nop>
noreme 9999.80 帮助(&?).版本(&V) :version<CR>
noreme 9999.90 帮助(&?).关于(&A) :intro<CR>
