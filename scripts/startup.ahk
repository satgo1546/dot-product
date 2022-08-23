#Warn
SetWorkingDir A_ScriptDir
; TODO... Menu, Tray, Icon, D:\Miscellaneous\Icons\classic_MyAHKScript.ico

; If (!GetKeyState("NumLock", "T")) {
; 	SendEvent {NumLock}
; }
capslock_count := 0

last_clipboard := ""

on_exit(ExitReason, ExitCode) {
	If ExitReason == "Logoff" or ExitReason == "Shutdown" {
		SetNumLockState false
		SetScrollLockState false
	}
}
OnExit on_exit

title := "Symbol Palette"
key_width4 := 48
key_height := 48

key_width5 := key_width4 * 1.25
key_width6 := key_width4 * 1.5
key_width7 := key_width4 * 1.75
key_width8 := key_width4 * 2
key_width9 := key_width4 * 2.25
key_width11 := key_width4 * 2.75
key_width25 := key_width4 * 6.25

keyboard_gui := Gui(, title)
keyboard_gui.Opt("+AlwaysOnTop -Caption +Owner -Theme")
hwnd := keyboard_gui.Hwnd
keyboard_gui.MarginX := 0
keyboard_gui.MarginY := 0
keyboard_gui.SetFont("s18", "M+ 1c")
vkey_buttons1 := keyboard_gui.AddButton("section x0 y0 w" . key_width4 . " h" . key_height . " vkey_button1").OnEvent("Click", button_handler)
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button2,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button3,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button4,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button5,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button6,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button7,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button8,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button9,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button10,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button11,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button12,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button13,
;Gui, Add, Button,         x+0 ys w%key_width8%  h%key_height% gbutton_handler vkey_button14,
;Gui, Add, Button, section x0 y+0 w%key_width6%  h%key_height% gbutton_handler vkey_button15,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button16,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button17,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button18,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button19,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button20,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button21,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button22,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button23,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button24,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button25,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button26,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button27,
;Gui, Add, Button,         x+0 ys w%key_width6%  h%key_height% gbutton_handler vkey_button28,
;Gui, Add, Button, section x0 y+0 w%key_width7%  h%key_height% gbutton_handler vkey_button29,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button30,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button31,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button32,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button33,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button34,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button35,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button36,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button37,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button38,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button39,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button40,
;Gui, Add, Button,         x+0 ys w%key_width9%  h%key_height% gbutton_handler vkey_button41,
;Gui, Add, Button, section x0 y+0 w%key_width9%  h%key_height% gbutton_handler vkey_button42,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button43,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button44,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button45,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button46,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button47,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button48,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button49,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button50,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button51,
;Gui, Add, Button,         x+0 ys w%key_width4%  h%key_height% gbutton_handler vkey_button52,
;Gui, Add, Button,         x+0 ys w%key_width11% h%key_height% gbutton_handler vkey_button53,
;Gui, Add, Button, section x0 y+0 w%key_width5%  h%key_height% gbutton_handler vkey_button54,
;Gui, Add, Button,         x+0 ys w%key_width5%  h%key_height% gbutton_handler vkey_button55,
;Gui, Add, Button,         x+0 ys w%key_width5%  h%key_height% gbutton_handler vkey_button56,
;Gui, Add, Button,         x+0 ys w%key_width25% h%key_height% gbutton_handler vkey_button57,
;Gui, Add, Button,         x+0 ys w%key_width5%  h%key_height% gbutton_handler vkey_button58,
;Gui, Add, Button,         x+0 ys w%key_width5%  h%key_height% gbutton_handler vkey_button59,
;Gui, Add, Button,         x+0 ys w%key_width5%  h%key_height% gbutton_handler vkey_button60,
;Gui, Add, Button,         x+0 ys w%key_width5%  h%key_height% gbutton_handler vkey_button61,
keyboard_gui.Show("xCenter y" . key_height . " Hide")
;SatgosSymbolPalette
;WinSet, AlwaysOnTop, On, ahk_id %hwnd%

; Disable Win key
; Assigning the modifier key to be a “prefix” for at least one other hotkey retains the modifiying function.
LWin:: {
	show_symbol_palette([])
}
RWin:: {
	show_symbol_palette([])
}
LWin & CapsLock:: {
}
RWin & CapsLock:: {
}

CapsLock:: {
	global capslock_count
	capslock_count++
	If (capslock_count > 1) {
		Return
	}
	If (GetKeyState("CapsLock", "T")) {
		SetCapsLockState false
	} Else {
		toggle_ime_convmode()
		;KeyWait, %A_ThisHotkey%, T0.5
		;If (ErrorLevel) {
			;toggle_ime_convmode()
			;SetCapsLockState On
		;}
	}
}

CapsLock Up:: {
	global capslock_count
	capslock_count := 0
}

multi_tap(characters) {
	static count
	If (StrLen(characters) <= 1) {
		count := 1
		SendText characters
	} Else {
		send_string := ""
		If (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 500) {
			count += 1
			If (count > StrLen(characters)) {
				count := 1
			}
			send_string .= "`b"
		} Else {
			count := 1
		}
		send_string .= SubStr(characters, count, 1)
		SendText send_string
	}
}

<#+a::multi_tap("ĀÁǍÀÂÄⱭ")
<#a:: multi_tap("āáǎàâäɑ")
<#+c::multi_tap("ÇĈ")
<#c:: multi_tap("çĉ")
<#+e::multi_tap("ĒÉĚÈÊË")
<#e:: multi_tap("ēéěèêë")
<#+i::multi_tap("ĪÍǏÌÎÏ")
<#i:: multi_tap("īíǐìîï")
<#+m::multi_tap("Ḿ")
<#m:: multi_tap("ḿ")
<#+n::multi_tap("Ǹ")
<#n:: multi_tap("ǹ")
<#+o::multi_tap("ŌÓǑÒÔÖ")
<#o:: multi_tap("ōóǒòôö")
<#+s::multi_tap("Ŝ")
<#s:: multi_tap("ŝ")
<#+u::multi_tap("ŪÚǓÙÛ")
<#u:: multi_tap("ūúǔùû")
<#+v::multi_tap("ÜǕǗǙǛ")
<#v:: multi_tap("üǖǘǚǜ")
<#+y::multi_tap("ŸŶ")
<#y:: multi_tap("ÿŷ")
<#+z::multi_tap("Ẑ")
<#z:: multi_tap("ẑ")

>!+a::Send "Α"
>!+b::Send "Β"
>!+c::Send "Ψ"
>!+d::Send "Δ"
>!+e::Send "Ε"
>!+f::Send "Φ"
>!+g::Send "Γ"
>!+h::Send "Η"
>!+i::Send "Ι"
>!+j::Send "Ξ"
>!+k::Send "Κ"
>!+l::Send "Λ"
>!+m::Send "Μ"
>!+n::Send "Ν"
>!+o::Send "Ο"
>!+p::Send "Π"
>!+q::Return
>!+r::Send "Ρ"
>!+s::Send "Σ"
>!+t::Send "Τ"
>!+u::Send "Θ"
>!+v::Send "Ω"
>!+w::Return
>!+x::Send "Χ"
>!+y::Send "Υ"
>!+z::Send "Ζ"

>!a::Send "α"
>!b::Send "β"
>!c::Send "ψ"
>!d::Send "δ"
>!e::Send "ε"
>!f::Send "φ"
>!g::Send "γ"
>!h::Send "η"
>!i::Send "ι"
>!j::Send "ξ"
>!k::Send "κ"
>!l::Send "λ"
>!m::Send "μ"
>!n::Send "ν"
>!o::Send "ο"
>!p::Send "π"
>!q::Return
>!r::Send "ρ"
>!s::Send "σ"
>!t::Send "τ"
>!u::Send "θ"
>!v::Send "ω"
>!w::Send "ς"
>!x::Send "χ"
>!y::Send "υ"
>!z::Send "ζ"

#NumpadSub::Send "−"
#HotIf WinActive("ahk_exe LyX.exe")
#NumpadAdd::Send "\pm{Space}"
#NumpadMult::Send "\times{Space}"
#NumpadDiv::Send "\div{Space}"
#-::Send "--"
#,::Send "\le{Space}"
#+,::Send "\leqslant{Space}"
#.::Send "\ge{Space}"
#+.::Send "\geqslant{Space}"
^1::Send "{^}2{Right}"
^2::Send "\sqrt{Space}"
^/::Send "!mf"
^+/::Send "^+{Left}!mf{Down}"
#HotIf WinActive("ahk_exe Mathematica.exe")
^1::Send "^62{Right}"
#HotIf
#NumpadAdd::Send "±"
>!=::Send "±"
>!-::Send "−"
#NumpadMult::Send "×"
>!8::Send "×"
#NumpadDiv::Send "÷"
>!/::Send "÷"
#-::Send "–"
#,::Send "≤"
#+,::multi_tap("⟨⩽")
#.::Send "≥"
#+.::multi_tap("⟩⩾")

#HotIf WinActive("ahk_exe winword.exe")
#^0::
#^1::
#^2::
#^3::
#^4::
#^5::
#^6::
#^7::
#^8::
#^9:: {
	c := SubStr(A_ThisHotkey, 3, 1)
	Send "^=" . c . "^="
}

#+0::
#+1::
#+2::
#+3::
#+4::
#+5::
#+6::
#+7::
#+8::
#+9:: {
	c := SubStr(A_ThisHotkey, 3, 1)
	Send "^+=" . c . "^+="
}

#HotIf
#^0::Send "₀"
#^1::Send "₁"
#^2::Send "₂"
#^3::Send "₃"
#^4::Send "₄"
#^5::Send "₅"
#^6::Send "₆"
#^7::Send "₇"
#^8::Send "₈"
#^9::Send "₉"

#+0::Send "⁰"
#+1::Send "¹"
#+2::Send "²"
#+3::Send "³"
#+4::Send "⁴"
#+5::Send "⁵"
#+6::Send "⁶"
#+7::Send "⁷"
#+8::Send "⁸"
#+9::Send "⁹"

#[::Send "〖"
#]::Send "〗"

#HotIf WinExist(keyboard_gui) && False
`::button_keydown(1)
` Up::button_keyup(1)
1::button_keydown(2)
1 Up::button_keyup(2)
2::button_keydown(3)
2 Up::button_keyup(3)
3::button_keydown(4)
3 Up::button_keyup(4)
4::button_keydown(5)
4 Up::button_keyup(5)
5::button_keydown(6)
5 Up::button_keyup(6)
6::button_keydown(7)
6 Up::button_keyup(7)
7::button_keydown(8)
7 Up::button_keyup(8)
8::button_keydown(9)
8 Up::button_keyup(9)
9::button_keydown(10)
9 Up::button_keyup(10)
0::button_keydown(11)
0 Up::button_keyup(11)
-::button_keydown(12)
VKBD Up::button_keyup(12)
=::button_keydown(13)
VKBB Up::button_keyup(13)
q::button_keydown(16)
q Up::button_keyup(16)
w::button_keydown(17)
w Up::button_keyup(17)
e::button_keydown(18)
e Up::button_keyup(18)
r::button_keydown(19)
r Up::button_keyup(19)
t::button_keydown(20)
t Up::button_keyup(20)
y::button_keydown(21)
y Up::button_keyup(21)
u::button_keydown(22)
u Up::button_keyup(22)
i::button_keydown(23)
i Up::button_keyup(23)
o::button_keydown(24)
o Up::button_keyup(24)
p::button_keydown(25)
p Up::button_keyup(25)
[::button_keydown(26)
[ Up::button_keyup(26)
]::button_keydown(27)
] Up::button_keyup(27)
\::button_keydown(28)
\ Up::button_keyup(28)
a::button_keydown(30)
a Up::button_keyup(30)
s::button_keydown(31)
s Up::button_keyup(31)
d::button_keydown(32)
d Up::button_keyup(32)
f::button_keydown(33)
f Up::button_keyup(33)
g::button_keydown(34)
g Up::button_keyup(34)
h::button_keydown(35)
h Up::button_keyup(35)
j::button_keydown(36)
j Up::button_keyup(36)
k::button_keydown(37)
k Up::button_keyup(37)
l::button_keydown(38)
l Up::button_keyup(38)
`;::button_keydown(39)
VKBA Up::button_keyup(39)
'::button_keydown(40)
VKDE Up::button_keyup(40)
z::button_keydown(43)
z Up::button_keyup(43)
x::button_keydown(44)
x Up::button_keyup(44)
c::button_keydown(45)
c Up::button_keyup(45)
v::button_keydown(46)
v Up::button_keyup(46)
b::button_keydown(47)
b Up::button_keyup(47)
n::button_keydown(48)
n Up::button_keyup(48)
m::button_keydown(49)
m Up::button_keyup(49)
,::button_keydown(50)
VKBC Up::button_keyup(50)
.::button_keydown(51)
VKBE Up::button_keyup(51)
/::button_keydown(52)
VKBF Up::button_keyup(52)
#HotIf

#F1:: {
	show_symbol_palette([""
		. "", "∣", "∥", "⟂", "", "", "", "", "", "", "", "∈", "∋", ""
		, "", "=", "<", ">", "≤", "≥", "≲", "≳", "≦", "≧", "⩽", "⩾", "≃", ""
		, "", "∼", "≺", "≻", "⪯", "⪰", "≼", "≽", "≾", "≿", "≅", "≆", ""
		, "", "≈", "⊂", "⊃", "⊆", "⊇", "⫇", "⫈", "⫅", "⫆", "⪋", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F1:: {
	show_symbol_palette([""
		. "", "∤", "∦", "⫽", "", "", "", "", "", "", "", "∉", "∌", ""
		, "", "≠", "≮", "≯", "≰", "≱", "≴", "≵", "", "", "", "", "", ""
		, "", "≁", "⊀", "⊁", "⪱", "⪲", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
#F2:: {
	show_symbol_palette([""
		. "", "¬", "∧", "∨", "⊕", "⊙", "⊼", "", "", "⊤", "⊥", "±", "∓", ""
		, "", "∁", "∩", "∪", "∖", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F2:: {
	show_symbol_palette([""
		. "", "¨", "¯", "<", "≤", "=", "≥", ">", "≠", "∨", "∧", "+", "×", ""
		, "", "?", "⍵", "⍷", "⍴", "∼", "↑", "↓", "⍳", "⍜", "⋆", "←", "→", ""
		, "", "⍺", "⌈", "⌊", "", "⍙", "⍢", "∘", "'", "⎕", "", "", ""
		, "", "⊂", "⊃", "∩", "∪", "⊥", "⊤", "∣", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
#F3:: {
	show_symbol_palette([""
		. "⅟", "½", "↉", "⅓", "⅔", "¼", "¾", "⅕", "⅖", "⅗", "⅘", "⅙", "⅚", ""
		, "", "∵", "∶", "°", "′", "″", "‴", "⁗", "", "", "", "", "", "∎"
		, "", "∴", "∷", "⩵", "≔", "", "", "", "", "", "", "", ""
		, "", "∠", "⋕", "⧣", "", "", "", "", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F3:: {
	show_symbol_palette([""
		. "⅐", "⅛", "⅜", "⅝", "⅞", "⅑", "⅒", "", "⁺", "⁽", "⁾", "⁻", "⁼", ""
		, "", "", "", "", "", "", "", "", "₊", "₍", "₎", "₋", "₌", ""
		, "", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹", "⁰", "⁄", ""
		, "", "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉", "₀", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
#F4:: {
	show_symbol_palette([""
		. "", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "", "", ""
		, "", "", "ς", "ε", "ρ", "τ", "υ", "θ", "ι", "ο", "π", "", "", ""
		, "", "α", "σ", "δ", "φ", "γ", "η", "ξ", "κ", "λ", "", "", ""
		, "", "ζ", "χ", "ψ", "ω", "β", "ν", "μ", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F4:: {
	show_symbol_palette([""
		. "", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "", "", ""
		, "", "", "Σ", "Ε", "Ρ", "Τ", "Υ", "Θ", "Ι", "Ο", "Π", "", "", ""
		, "", "Α", "Σ", "Δ", "Φ", "Γ", "Η", "Ξ", "Κ", "Λ", "", "", ""
		, "", "Ζ", "Χ", "Ψ", "Ω", "Β", "Ν", "Μ", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
#F5:: {
	show_symbol_palette([""
		. "⓪", "①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⑩", "", "", ""
		, "", "⑪", "⑫", "⑬", "⑭", "⑮", "⑯", "⑰", "⑱", "⑲", "⑳", "", "", ""
		, "", "㉑", "㉒", "㉓", "㉔", "㉕", "㉖", "㉗", "㉘", "㉙", "㉚", "", ""
		, "", "㉛", "㉜", "㉝", "㉞", "㉟", "㊱", "㊲", "㊳", "㊴", "㊵", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F5:: {
	show_symbol_palette([""
		. "🄋", "➀", "➁", "➂", "➃", "➄", "➅", "➆", "➇", "➈", "➉", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "⓵", "⓶", "⓷", "⓸", "⓹", "⓺", "⓻", "⓼", "⓽", "⓾", "", ""
		, "", "㊶", "㊷", "㊸", "㊹", "㊺", "㊻", "㊼", "㊽", "㊾", "㊿", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
#F6:: {
	show_symbol_palette([""
		. "⓿", "❶", "❷", "❸", "❹", "❺", "❻", "❼", "❽", "❾", "❿", "", "", ""
		, "", "⓫", "⓬", "⓭", "⓮", "⓯", "⓰", "⓱", "⓲", "⓳", "⓴", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F6:: {
	show_symbol_palette([""
		. "🄌", "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒", "➓", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
#F7:: {
	show_symbol_palette([""
		. "●", "◎", "⊙", "○", "■", "◆", "★", "□", "◇", "☆", "", "", "", ""
		, "", "↖", "↑", "↗", "◤", "▲", "◥", "◸", "△", "◹", "░", "▒", "▓", "█"
		, "", "←", "↓", "→", "◀", "", "▶", "◁", "", "▷", "", "", ""
		, "", "↙", "↓", "↘", "◣", "▼", "◢", "◺", "▽", "◿", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F7:: {
	show_symbol_palette([""
		. "", "▁", "▂", "▃", "▄", "▅", "▅", "▆", "▇", "█", "", "", "", ""
		, "", "▘", "▔", "▝", "▛", "▀", "▜", "▉", "▊", "▋", "▌", "▍", "▎", "▏"
		, "", "▏", "▞", "▕", "▌", "█", "▐", "", "▚", "", "", "", ""
		, "", "▖", "▁", "▗", "▙", "▄", "▟", "", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
#F8:: {
	show_symbol_palette([""
		. "", "─", "│", "", "━", "┃", "", "═", "║", "", "", "", "", ""
		, "", "┌", "┬", "┐", "┏", "┳", "┓", "╔", "╦", "╗", "╭", "╮", "╳", "╲"
		, "", "├", "┼", "┤", "┣", "╋", "┫", "╠", "╬", "╣", "╰", "╯", ""
		, "", "└", "┴", "┘", "┗", "┻", "┛", "╚", "╩", "╝", "╱", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F8:: {
	show_symbol_palette([""
		. "", "⏜", "⏝", "⎴", "⎵", "⏞", "⏟", "⎪", "⎰", "", "", "", "", ""
		, "", "⎛", "⎞", "⎡", "⎤", "⎧", "⎫", "⌠", "⎱", "", "", "", "", ""
		, "", "⎜", "⎟", "⎢", "⎥", "⎨", "⎬", "⎮", "⎲", "", "", "", ""
		, "", "⎝", "⎠", "⎣", "⎦", "⎩", "⎭", "⌡", "⎳", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
#F9:: {
	show_symbol_palette([""
		. "🄀", "⒈", "⒉", "⒊", "⒋", "⒌", "⒍", "⒎", "⒏", "⒐", "⒑", "", "", ""
		, "", "⒒", "⒓", "⒔", "⒕", "⒖", "⒗", "⒘", "⒙", "⒚", "⒛", "", "", ""
		, "", "⑴", "⑵", "⑶", "⑷", "⑸", "⑹", "⑺", "⑻", "⑼", "⑽", "", ""
		, "", "⑾", "⑿", "⒀", "⒁", "⒂", "⒃", "⒄", "⒅", "⒆", "⒇", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F9:: {
	show_symbol_palette([""
		. "‥", "⿰", "⿱", "⿲", "⿳", "⿴", "⿵", "⿶", "⿷", "⿸", "⿹", "⿺", "⿻", ""
		, "", "︻", "︵", "﹇", "︷", "﹃", "﹁", "︱", "￤", "︳", "︴", "‖", "︰", ""
		, "", "︼", "︶", "﹈", "︸", "﹄", "﹂", "￣", "﹉", "﹊", "﹋", "﹌", ""
		, "", "︹", "︺", "︽", "︾", "︿", "﹀", "", "", "﹍", "﹎", "﹏", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
#F10:: {
	show_symbol_palette([""
		. "", "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ", "Ⅶ", "Ⅷ", "Ⅸ", "Ⅹ", "Ⅺ", "Ⅻ", ""
		, "", "ⅰ", "ⅱ", "ⅲ", "ⅳ", "ⅴ", "ⅵ", "ⅶ", "ⅷ", "ⅸ", "ⅹ", "ⅺ", "ⅻ", ""
		, "", "㈠", "㈡", "㈢", "㈣", "㈤", "㈥", "㈦", "㈧", "㈨", "㈩", "", ""
		, "", "㊀", "㊁", "㊂", "㊃", "㊄", "㊅", "㊆", "㊇", "㊈", "㊉", "",
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F10:: {
	show_symbol_palette([""
		. "", "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "⚀", "⚁", "⚂", "⚃", "⚄", "⚅", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "☰", "☱", "☲", "☳", "☴", "☵", "☶", "☷", "⚊", "⚋", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
#F11:: {
	show_symbol_palette([""
		. "", "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "§", "№", "℡", "〓", "℃", "℉", "ℓ", "", "", "", "♀", "♂", ""
		, "", "〃", "々", "〆", "〒", "※", "", "", "", "", "", "", ""
		, "", "•", "‣", "⁎", "⁑", "†", "‡", "⹋", "℮", "‧", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}
+#F11:: {
	show_symbol_palette([""
		. "", "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}


#F21:: {
	show_symbol_palette([""
		. "", "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", "", "", "", "", "", "", "", ""
		, "", "", "", "", " ", "", "", ""
	. ""])
}

#F12:: {
	show_symbol_palette([""
		. "``", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "⌫"
		, "↹", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "[", "]", "\"
		, "⇬", "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'", "↵"
		, "⇧", "z", "x", "c", "v", "b", "n", "m", ",", ".", "/", "⇧"
		, "^", "⌘", "⌥", " ", "⌥", "⌘", "❖", "^"
	. ""])
}
+#F12:: {
	show_symbol_palette([""
		. "``", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "⌫"
		, "↹", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "[", "]", "\"
		, "⇬", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "'", "↵"
		, "⇧", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/", "⇧"
		, "^", "⌘", "⌥", " ", "⌥", "⌘", "❖", "^"
	. ""])
}

button_keydown(number) {
	ControlClick "x1 y1", "key_button" . number, , , , "D"
	button_event(number)
}

button_keyup(number) {
	ControlClick "x1 y1", "key_button" . number, , , , "U"
}

button_handler(control, info) {
	button_event(SubStr(control.Name, 11))
}

button_event(number) {
	;GuiControlGet, symbol, , key_button%number%, Text
	Send "%"
}

show_symbol_palette(symbols) {
	global hwnd
	If (symbols.Length > 0) {
		For index, symbol in symbols {
			;GuiControlGet, button_enabled, Enabled, key_button%index%
			button_enabled := 0
			If (button_enabled) {
				;GuiControl, Text, key_button%index%, %symbol%
			}
		}
		keyboard_gui.Show("NA")
		;WinSet, Transparent, 192, ahk_id %hwnd%
	} Else {
		keyboard_gui.Hide()
	}
}

set_next_input_language() {
	WinExist("A")
	PostMessage 0x50, 4, , ControlGetFocus()
}

toggle_ime_convmode() {
	current_convmode := get_ime_convmode()
	; 默认为英文状态，则转换模式为268435456。
	If (current_convmode = 0 || current_convmode = 0x10000000) {
		set_ime_convmode(1)
	} Else {
		set_ime_convmode(0)
	}
}

set_ime_convmode(mode) {
	SendMessage 0x0283 ; Message = WM_IME_CONTROL
		, 0x0002 ; wParam = IMC_SETCONVERSIONMODE
		, mode ; lParam = CONVERSIONMODE
		, DllCall("imm32\ImmGetDefaultIMEWnd", "UInt", WinExist("A"))
}

get_ime_convmode() {
	Return SendMessage(0x0283 ; Message = WM_IME_CONTROL
		, 0x0001 ; wParam = IMC_GETCONVERSIONMODE
		, 0 ; lParam = 0
		, DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", WinExist("A")))
}

text_to_tex(str) {
	; StrReplace不好用，因为它不知道区不区分大小写
	str := RegExReplace(str, "“", "````")
	str := RegExReplace(str, "”", "''")
	str := RegExReplace(str, "‘", "``")
	str := RegExReplace(str, "’", "'")
	str := RegExReplace(str, "\bLaTeX\b", "\LaTeX{}")
	str := RegExReplace(str, "TeX\b", "\TeX{}")
	str := RegExReplace(str, "\bTeXbook\b", "\TeX book")
	str := RegExReplace(str, "\bMETAFONT\b", "\MF{}")
	str := RegExReplace(str, "\bMETAFONTbook\b", "\MF book")
	str := RegExReplace(str, "−", "--")
	str := RegExReplace(str, "—", "---")
	str := RegExReplace(str, "i)\bPh\.\s?D\. ", "Ph.D.\ ")
	str := RegExReplace(str, "\b(Miss|Ms|Mrs?|cf|v\.?s)\.\s", "$1.~")
	str := RegExReplace(str, Chr(160), "~")
	str := RegExReplace(str, "%", "\%")
	str := RegExReplace(str, "i)(?:https?|s?ftps?|git|telnet)://[\w~!@#\$%\^&\*\(\)\[\]\{\}<>,\./\?=\+:;`"'-]{4,2083}", "\url{$0}")
	str := RegExReplace(str, "(\w)\s&\s(\w)", "$1 \& $2")
	str := RegExReplace(str, "$(\d)", "\$$$1")
	str := RegExReplace(str, "#(\d)", "\#$1")
	str := RegExReplace(str, "<em>(.+?)</em>", "\emph{$1}")
	Return str
}

XButton1::Return
XButton2::Return

Launch_App1::Return
Launch_App2::Return
Media_Next::Return
Media_Prev::Return
Media_Play_Pause::Return
Media_Stop:: {
	If ProcessExist("baidunetdisk.exe") + ProcessExist("uget.exe") + ProcessExist("uTorrent.exe") {
		result := MsgBox, 0x131, "睡眠", "还有下载任务。睡眠吗？"
	} Else {
		result := MsgBox, 0x1, "睡眠", "睡眠吗？"
	}
	If result == "OK" {
		; Parameter #1: Pass 1 instead of 0 to hibernate rather than suspend.
		; Parameter #2: Pass 1 instead of 0 to suspend immediately rather than asking each application for permission.
		; Parameter #3: Pass 1 instead of 0 to disable all wake events.
		DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
	}
}
Browser_Back::Send "{Volume_Down}"
Browser_Forward::Send "{Volume_Up}"
Browser_Home::Return
Launch_Mail:: {
	global last_clipboard
	If (last_clipboard == Clipboard) {
		ToolTip "已经转换过了。"
	} Else {
		last_clipboard := text_to_tex(Clipboard)
		Clipboard := last_clipboard
		ToolTip "将剪贴板文本转换为 LaTeX 格式。"
	}
	SetTimer RemoveToolTip, -1000
}

#+/:: {
	ProcessClose "ctfmon.exe"
	ProcessClose "ChsIME.exe"
}

RemoveToolTip() {
	ToolTip
}
