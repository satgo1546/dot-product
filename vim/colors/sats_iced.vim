"==============================================================================
" ■ Sat's Iced.vim
"==============================================================================

set background=light
highlight clear
syntax reset
let g:colors_name = "sats_iced"

hi Normal         gui=none           guibg=White      guifg=Black
hi ErrorMsg       gui=italic         guibg=White      guifg=DarkRed
hi WarningMsg     gui=none           guibg=White      guifg=Brown
hi ModeMsg        gui=bold                            guifg=DarkGreen
hi StatusLine     gui=none           guibg=DarkGreen  guifg=White
hi StatusLineNC   gui=none           guibg=#7ebe7f    guifg=White
hi WildMenu       gui=bold           guibg=#e0ffe0    guifg=Black
hi VertSplit      gui=none           guibg=DarkGreen  guifg=White
hi Visual                            guibg=#c6ebff
hi VisualNOS      gui=reverse
hi Cursor                            guibg=fg         guifg=bg
hi lCursor                           guibg=#004000    guifg=bg
hi LineNr         gui=none           guibg=#f0f9ff    guifg=#7fccff
hi CursorLineNr   gui=bold           guibg=#bfe5ff    guifg=#f0f9ff
hi link MoreMsg Question
hi Question       gui=italic                          guifg=DarkGreen
hi NonText        gui=none           guibg=bg         guifg=#bddebf
hi IncSearch      gui=none           guibg=#ffff90
hi Search                            guibg=Yellow
hi SpecialKey                                         guifg=DarkGreen
hi Title          gui=bold                            guifg=DarkGreen
hi Folded         gui=bold,underline guibg=NONE       guifg=#a7cfe6
hi FoldColumn     gui=none           guibg=#f0f9ff    guifg=#a7cfe6
hi CursorColumn   NONE
hi CursorLine     NONE
hi TabLineSel     gui=none           guibg=bg         guifg=fg
hi TabLine        gui=none           guibg=#7ebe7f    guifg=White
hi TabLineFill    gui=none           guibg=DarkGreen
hi ColorColumn                       guibg=#f0f9ff

hi DiffAdd                           guibg=LightGreen guifg=NONE
hi DiffChange                        guibg=#c7bc8d    guifg=NONE
hi DiffDelete                        guibg=LightRed   guifg=NONE
hi DiffText       gui=bold,underline guibg=NONE

hi Comment                                            guifg=#009900
hi String                                             guifg=#d0a003
hi Character                                          guifg=#ba5601
hi Number                                             guifg=#a50e00
hi Constant                                           guifg=#a50040
hi link Boolean Keyword
hi Statement      gui=bold                            guifg=#2b96c1
hi Operator       gui=none                            guifg=#0080c0
hi PreProc                                            guifg=#a66baf
hi Identifier                                         guifg=DarkCyan
hi! link cUserLabel Identifier
hi! link Type Keyword
hi link Delimiter Operator
hi link cParen Delimiter
hi MatchParen     gui=underline      guibg=NONE
hi SpecialComment gui=bold                            guifg=NONE
hi Underlined     gui=underline                       guifg=NONE
hi Error          gui=undercurl      guibg=NONE       guifg=NONE       guisp=Red
hi Todo           gui=bold,undercurl guibg=NONE       guifg=Orange     guisp=Orange

hi Sats_URL       gui=underline                       guifg=Blue
hi link helpURL Sats_URL

hi! link rcLanguage Keyword
