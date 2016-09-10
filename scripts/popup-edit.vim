"==============================================================================
" ■ popup-edit.vim
"------------------------------------------------------------------------------
"   Add -S path/to/popup-edit.vim to, for example, core.editor in `git config`.
"==============================================================================

set showtabline=1
if has("gui_running")
	set guioptions-=mTlr
	set columns=80 lines=24
endif
go | startinsert
