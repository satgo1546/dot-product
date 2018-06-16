"==============================================================================
" ■ line.vim
"==============================================================================

function! s:hiname(m, i)
	return "Sats_StatusLine" . a:m . a:i
endfunction

function! s:hi(m, i)
	return "%#" . s:hiname(a:m, a:i) . "#"
endfunction

function! s:set_color(m, fg, bg, x)
	for i in [0, 1, 2]
		execute "hi " . s:hiname(a:m, i)
		\ . " gui=" . a:x . " guifg=" . a:fg . " guibg=" . a:bg[i]
	endfor
endfunction

function! <SID>Sats_HighlightStatusLine()
	hi Sats_StatusLineMod guifg=#332a1a guibg=#ffe0e0 gui=bold
	call s:set_color("N" , "#1a2b33", ["#85d7ff", "#c2ebff", "#e0f5ff"], "none")
	call s:set_color("I" , "#2d331a", ["#dfff85", "#efffc2", "#f7ffe0"], "none")
	call s:set_color("R" , "#332f1a", ["#ffeb85", "#fff5c2", "#fffae0"], "none")
	call s:set_color("V" , "#2c1a33", ["#df85ff", "#efc2ff", "#f7e0ff"], "none")
	call s:set_color("S" , "#2c2726", ["#dfc2c2", "#efe1e0", "#f7f0ef"], "none")
	call s:set_color("NC", "#7fccff", ["#f0f9ff", "#f0f9ff", "#f0f9ff"], "underline")
	call s:set_color("RO", "#666666", ["#c0c0c0", "#dbdbdb", "#eeeeee"], "none")
	call s:set_color("C" , "#23282a", ["#b0c9d5", "#d7e4ea", "#ebf1f4"], "none")
endfunction

function! <SID>Sats_RefreshStatusLine()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Sats_StatusLine(' . nr . ')')
  endfor
endfunction

function! Sats_StatusLine(nr)
	let r = ""
	let m = mode()
	if winnr() == a:nr
		if getwinvar(a:nr, "&readonly")
			let m = "RO"
		elseif m ==# "n"
			let m = "N"
		elseif m ==? "v" || m ==# ""
			let m = "V"
		elseif m ==? "s" || m ==# ""
			let m = "S"
		elseif m ==# "i"
			let m = "I"
		elseif m ==# "R"
			let m = "R"
		elseif m ==# "c"
			let m = "C"
		endif
	else
		let m = "NC"
	endif
	let r .= getwinvar(a:nr, "&modified") ? "%#Sats_StatusLineMod#" : s:hi(m, 0)
	let r .= " \u29d6 "
	let r .= s:hi(m, 1) . " C%02c "
	let r .= s:hi(m, 2) . " %f%( %q%)%=%(%h%w %) %Y "
	let r .= s:hi(m, 1) . " U+%04B "
	let r .= s:hi(m, 0) . " %4P "
	return r
endfunction

augroup Sats_StatusLine
  autocmd!
	autocmd VimEnter,ColorScheme * call <SID>Sats_HighlightStatusLine()
  autocmd VimEnter,WinEnter,BufWinEnter * call <SID>Sats_RefreshStatusLine()
augroup END
