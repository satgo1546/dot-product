"==============================================================================
" ■ menu.vim
"------------------------------------------------------------------------------
"   Use :nnoreme instead of :an.
"==============================================================================

let g:NetrwTopLvlMenu = "文件(&F).&Netrw"
nnoreme 10.50 文件(&F).&Netrw <Nop>
nnoreme 10.9990 文件(&F).-999- <Nop>
nnoreme 10.9999 文件(&F).退出(&X) :qa<CR>
nnoreme 20.20 编辑(&E).-1- <Nop>
nnoreme 20.21 编辑(&E).显示字符信息(&A)<Tab>ga ga
nnoreme 20.22 编辑(&E).显示字符的UTF-&8编码<Tab>g8 g8
nnoreme 20.44 编辑(&E).插入&UTF-8编码的C转义序列 :call EnterEncodedEscapeSequences("utf-8")<CR>
nnoreme 20.45 编辑(&E).插入GB&K编码的C转义序列 :call EnterEncodedEscapeSequences("gbk")<CR>
nnoreme 20.60 编辑(&E).-2- <Nop>
nnoreme 20.61 编辑(&E).十六进制编辑(&X) :call XxdConv()<CR>
nnoreme 20.62 编辑(&E).十六进制编辑返回(&R) :call XxdBack()<CR>
nnoreme 20.70.10 编辑(&E).大幅改动(&B).删除空格(&D) :%s/ //g<CR>
nnoreme 20.70.15 编辑(&E).大幅改动(&B).删除空白(&W) :%s/\s+//g<CR>
nnoreme 20.70.20 编辑(&E).大幅改动(&B).奇偶行分离(&E) :call SeparateEvenOddLines()<CR>
let s:names = sort(map(split(globpath(&runtimepath, "colors/*.vim"), "\n"), 'substitute(v:val, "\\c.*[/\\\\:\\]]\\([^/\\\\:]*\\)\\.vim", "\\1", "")'), 1)
let s:i = 1
for s:name in s:names
	execute "nnoreme 40.10.40." . s:i . " 工具(&T).&Vim.色彩方案(&C)." . s:name . " :colorscheme " . s:name . "<CR>"
	let s:i += 1
endfor
unlet s:i s:name s:names
nnoreme 40.10.50 工具(&T).&Vim.显示语法栈(&S) :call EchoSynStack()<CR>
nnoreme 40.10.60 工具(&T).&Vim.色彩测试(&L) :tabnew $VIMRUNTIME/syntax/colortest.vim<Bar>so %<CR>
nnoreme 40.10.70 工具(&T).&Vim.高亮测试(&H) :runtime syntax/hitest.vim<CR>
nnoreme 40.20 工具(&T).转换为HTML(&H) :runtime syntax/2html.vim<CR>
nnoreme 40.50 工具(&T).-1- <Nop>
nnoreme 40.51 工具(&T).字数统计(&G)<Tab>g<C-g> :call ShowWordCount()<CR>
nnoreme 40.52 工具(&T).启用拼写检查(&S) :setlocal spell spelllang=en,cjk<CR>
nnoreme 40.53 工具(&T).禁用拼写检查(&N) :setlocal nospell<CR>
nnoreme 40.90 工具(&T).-2- <Nop>
nnoreme 40.91 工具(&T).编辑色彩方案(&C)
\ :execute "tabedit " . FindCurrentColorScheme()<CR>
nnoreme 40.92 工具(&T).编辑函数(&F)
\ :execute "tabedit " . findfile("functions.vim", &rtp)<CR>
nnoreme 40.93 工具(&T).编辑菜单(&M)
\ :execute "tabedit " . findfile("mymenu.vim", &rtp)<CR>
nnoreme 40.94 工具(&T).编辑文件类型(&D)
\ :execute "tabedit " . findfile("filetype.vim", &rtp)<CR>
nnoreme 40.95 工具(&T).编辑状态栏(&L)
\ :execute "tabedit " . findfile("line.vim", &rtp)<CR>
nnoreme 40.96 工具(&T).编辑代码片段(&S)
\ :execute "tabedit " . finddir("snippets", &rtp)<CR>
nnoreme 40.99 工具(&T).选项(&O)
\ :execute "tabedit " . findfile("vimrc", &rtp)<CR>
nnoreme 9999.10 帮助(&?).纵览(&O) :help<CR>
nnoreme 9999.11 帮助(&?).如何(&H) :help how-to<CR>
nnoreme 9999.15 帮助(&?).-1- <Nop>
nnoreme 9999.20 帮助(&?).笑着活下去(&S) :smile<CR>
nnoreme 9999.75 帮助(&?).-2- <Nop>
nnoreme 9999.80 帮助(&?).版本(&V) :version<CR>
nnoreme 9999.90 帮助(&?).关于(&A) :intro<CR>
