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
hi lCursor                           guibg=#521552    guifg=bg
hi link CursorIM lCursor
hi LineNr         gui=none           guibg=#f0f9ff    guifg=#7fccff
hi CursorLineNr   gui=bold           guibg=#bfe5ff    guifg=#f0f9ff
hi link MoreMsg Question
hi Question       gui=italic                          guifg=DarkGreen
hi NonText        gui=none           guibg=bg         guifg=#bddebf
hi IncSearch      gui=none           guibg=#ffff90
hi Search                            guibg=Yellow
hi SpecialKey                                         guifg=DarkGreen
hi Title          gui=bold                            guifg=DarkGreen
hi Conceal        gui=bold           guibg=NONE       guifg=NONE
hi Folded         gui=bold,underline guibg=NONE       guifg=#a7cfe6
hi FoldColumn     gui=none           guibg=#f0f9ff    guifg=#a7cfe6
hi CursorColumn   NONE
hi CursorLine     NONE
hi TabLineSel     gui=none           guibg=bg         guifg=fg
hi TabLine        gui=none           guibg=#7ebe7f    guifg=White
hi TabLineFill    gui=none           guibg=DarkGreen
hi ColorColumn                       guibg=#f0f9ff

hi DiffAdd                           guibg=LightGreen guifg=NONE
hi diffAdded                                          guifg=DarkGreen
hi DiffChange                        guibg=#c7bc8d    guifg=NONE
hi diffChanged                                        guifg=#c7bc8d
hi DiffDelete                        guibg=LightRed   guifg=NONE
hi diffDeleted                                        guifg=DarkRed
hi diffRemoved                                        guifg=DarkRed
hi DiffText       gui=bold,underline guibg=NONE
hi SpellBad       gui=undercurl                                        guisp=Red
hi SpellRare      gui=undercurl                                        guisp=Magenta
hi SpellCap       gui=undercurl                                        guisp=Green

hi Comment                                            guifg=#009900
hi String                                             guifg=#d0a003
hi Sats_StringSpecial gui=bold                        guifg=#d0a003
hi Character                                          guifg=#ba5601
hi Number                                             guifg=#a50e00
hi Constant                                           guifg=#a50040
hi link Boolean Keyword
hi Statement      gui=bold                            guifg=#2b96c1
hi Operator       gui=none                            guifg=#0080c0
hi link Delimiter Operator
hi PreProc                                            guifg=#a66baf
hi Identifier                                         guifg=NONE
hi Sats_RecognizedIdentifier                          guifg=SeaGreen
hi Type           gui=none                            guifg=SeaGreen
hi MatchParen     gui=underline      guibg=NONE
hi Special        gui=none                            guifg=#b9397e
hi SpecialComment gui=bold                            guifg=NONE
hi Underlined     gui=underline                       guifg=NONE
hi Error          gui=undercurl      guibg=NONE       guifg=NONE       guisp=Red
hi Todo           gui=bold,undercurl guibg=NONE       guifg=Orange     guisp=Orange

hi Sats_URL       gui=underline                       guifg=Blue

hi link helpURL Sats_URL
hi link helpHyperTextJump Underlined

hi link cUserLabel Identifier
hi link cType Keyword
hi link cParen Delimiter
hi link cppType cType

hi link rcLanguage Keyword

hi link pythonInclude Keyword

hi link rubyConstant NONE
hi link rubyStringDelimiter rubyString
hi link rubyDefine Keyword

hi link luaFunction Type
hi link luaFunc Sats_RecognizedIdentifier

hi link hexAddressFieldUnknown Error
hi link hexDataFieldUnknown Error

hi link jsonKeyword Sats_StringSpecial
hi link jsonNoise Delimiter
hi link jsonQuote String
hi link jsonNull Constant
