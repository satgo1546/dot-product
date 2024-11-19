;===============================================================================
; ■ startup.ahk
;-------------------------------------------------------------------------------
;   Various ways to aid keyboard input.
;===============================================================================
#Requires AutoHotkey v2.0
#Warn
SetWorkingDir A_ScriptDir
FileEncoding "UTF-8-RAW"
; TODO... Menu, Tray, Icon, D:\Miscellaneous\Icons\classic_MyAHKScript.ico

;-------------------------------------------------------------------------------
; Utilities
;-------------------------------------------------------------------------------

; Disable Win key while retaining the modifiying function.
~LWin::VKE8
~RWin::VKE8
; Disable extra buttons on the mouse.
XButton1::Return
XButton2::Return

#^v:: {
	SendText A_Clipboard
}

no_hold() {
	static count := Map()
	count.Default := 0
	If SubStr(A_ThisHotkey, -3) = " Up" {
		count[SubStr(A_ThisHotkey, 1, -3)] := 0
	} Else {
		count[A_ThisHotkey]++
		If count[A_ThisHotkey] > 1 {
			Exit
		}
	}
}

transform_selection(transform) {
	old_clipboard := ClipboardAll()
	A_Clipboard := ""
	Send "^c"
	If !ClipWait(.1) || InStr(A_Clipboard, "`n", false) == StrLen(A_Clipboard) || IsSpace(A_Clipboard) {
		result := transform("") . "fail"
	} Else {
		before := RegExMatch(A_Clipboard, "^\s*\n", &match) ? match[] : ""
		after := RegExMatch(A_Clipboard, "\r?\n\s*$", &match) ? match[]: ""
		result := before . transform(SubStr(A_Clipboard, StrLen(before) + 1, -StrLen(after))) . after . "succ"
	}
	A_Clipboard := result
	Send "^v"
	Sleep 0.1
	A_Clipboard := old_clipboard
	old_clipboard := ""
}
 
;-------------------------------------------------------------------------------
; Caps lock
;-------------------------------------------------------------------------------

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

CapsLock:: {
	no_hold()
	If (GetKeyState("CapsLock", "T")) {
		SetCapsLockState false
	} Else {
		toggle_ime_convmode()
	}
}

CapsLock Up:: {
	no_hold()
}

;-------------------------------------------------------------------------------
; Alternate graphs
;-------------------------------------------------------------------------------

keyboard_data := [
	[["×", "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉", "₀", "−", "±", unset,
	unset, "😾", "ς", "ε", "ρ", "τ", "υ", "θ", "ι", "ο", "π", unset, unset, unset,
	unset, "α", "σ", "δ", "φ", "γ", "η", "ξ", "κ", "λ", "°", "′", unset,
	unset, "ζ", "χ", "ψ", "ω", "β", "ν", "μ", "⟨", "⟩", "÷", "αβγ"],
	["≈", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹", "⁰", "", "", unset,
	unset, "", "Σ", "Ε", "Ρ", "Τ", "Υ", "Θ", "Ι", "Ο", "Π", unset, unset, unset,
	unset, "Α", "Σ", "Δ", "Φ", "Γ", "Η", "Ξ", "Κ", "Λ", "", "″", unset,
	unset, "Ζ", "Χ", "Ψ", "Ω", "Β", "Ν", "Μ", "≤", "≥", "", "ΑΒΓ"]],
	[["⓪", "①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⑩", "", "", unset,
	unset, "⑪", "⑫", "⑬", "⑭", "⑮", "⑯", "⑰", "⑱", "⑲", "⑳", unset, unset, unset,
	unset, "㉑", "㉒", "㉓", "㉔", "㉕", "㉖", "㉗", "㉘", "㉙", "㉚", "", unset,
	unset, "㉛", "㉜", "㉝", "㉞", "㉟", "㊱", "㊲", "㊳", "㊴", "㊵", "①②"],
	["🄀", "⒈", "⒉", "⒊", "⒋", "⒌", "⒍", "⒎", "⒏", "⒐", "⒑", "", "", unset,
	unset, "⒒", "⒓", "⒔", "⒕", "⒖", "⒗", "⒘", "⒙", "⒚", "⒛", unset, unset, unset,
	unset, "⑴", "⑵", "⑶", "⑷", "⑸", "⑹", "⑺", "⑻", "⑼", "⑽", "", unset,
	unset, "⑾", "⑿", "⒀", "⒁", "⒂", "⒃", "⒄", "⒅", "⒆", "⒇", "⒈⑵"]],
	[["●", "◎", "⊙", "○", "■", "◆", "★", "□", "◇", "☆", "", "", "", unset,
	unset, "↖", "↑", "↗", "◤", "▲", "◥", "◸", "△", "◹", "", unset, unset, unset,
	unset, "←", "↓", "→", "◀", "", "▶", "◁", "", "▷", "", "", unset,
	unset, "↙", "↓", "↘", "◣", "▼", "◢", "◺", "▽", "◿", "", "○△□"],
	["", "", "", "", "", "", "", "", "", "", "", "", "", "",
	unset, "", "", "", "", "", "", "", "", "", "", "", "", "",
	unset, "", "", "", "", "", "", "", "", "", "", "", "",
	unset, "", "", "", "", "", "", "", "", "", "", ""]],
	[["", "▁", "▂", "▃", "▄", "▅", "▅", "▆", "▇", "█", "▓", "▒", "░", unset,
	unset, "▘", "▔", "▝", "▛", "▀", "▜", "▉", "▊", "▋", "▌", unset, unset, unset,
	unset, "▏", "▞", "▕", "▌", "█", "▐", "▍", "▎", "▏", "▚", "", unset,
	unset, "▖", "▁", "▗", "▙", "▄", "▟", "", "", "", "", "▞"],
	["", "", "", "", "", "", "", "", "", "", "", "", "", unset,
	unset, "", "", "", "", "", "", "", "", "", "", unset, unset, unset,
	unset, "", "", "", "", "", "", "", "", "", "", "", unset,
	unset, "", "", "", "", "", "", "", "", "", "", ""]],
	[["╲", "─", "│", "╳", "━", "┃", "", "═", "║", "╭", "╮", "╰", "╯", unset,
	unset, "┌", "┬", "┐", "┏", "┳", "┓", "╔", "╦", "╗", "", unset, unset, unset,
	unset, "├", "┼", "┤", "┣", "╋", "┫", "╠", "╬", "╣", "", "", unset,
	unset, "└", "┴", "┘", "┗", "┻", "┛", "╚", "╩", "╝", "╱", "┼╋╬"],
	["", "", "", "", "", "", "", "", "", "", "", "", "", unset,
	unset, "", "", "", "", "", "", "", "", "", "", unset, unset, unset,
	unset, "", "", "", "", "", "", "", "", "", "", "", unset,
	unset, "", "", "", "", "", "", "", "", "", "", ""]],
	[["", "<h1>", "<h2>", "<h3>", "<h4>", "<h5>", "<h6>", "", "", "", "", "<del>", "", unset,
	unset, "<blockquote>", "<details>", "<summary>", "<ruby><rt></ruby>", "<table>", "<output>", "<ul>", "<em>", "<ol>", "<p>", unset, unset, unset,
	unset, "<a ", "<span ", "<div ", "<figure>", "<img>", "<hr>", "", "<kbd>", "<li>", "<dl>", "&apos;", unset,
	unset, "", "<s>", "<code>", "<var>", "<strong>", "", "<mark>", "<dt>", "<dd>", "", "</>"],
	["", "<!---->", "</h2>", "</h3>", "</h4>", "</h5>", "<sup>", "&amp;", "", "", "", "<sub>", "<ins>", unset,
	unset, "</blockquote>", "</details>", "</summary>", "", "", "</output>", "</ul>", "</em>", "</ol>", "</p>", unset, unset, unset,
	unset, "</a>", "</span>", "</div>", "</figure>", "", "", "", "</kbd>", "</li>", "</dl>", "&quot;", unset,
	unset, "", "</s>", "</code>", "</var>", "<b>", "", "</mark>", "&lt;", "&gt;", "", "</>"]],
	; [["", "", "", "", "", "", "", "", "", "", "", "", "", unset,
	; unset, "", "", "", "", "", "", "", "", "", "", unset, unset, unset,
	; unset, "", "", "", "", "", "", "", "", "", "", "", unset,
	; unset, "", "", "", "", "", "", "", "", "", "", "###"],
	; ["", "", "", "", "", "", "", "", "", "", "", "", "", unset,
	; unset, "", "", "", "", "", "", "", "", "", "", unset, unset, unset,
	; unset, "", "", "", "", "", "", "", "", "", "", "", unset,
	; unset, "", "", "", "", "", "", "", "", "", "", "###"]],
]
; WS_EX_TRANSPARENT makes mouse clicks pass through it. I don't know why, but it works.
keyboard_gui := Gui("+AlwaysOnTop -Caption +Owner -Theme +E0x20", "Symbol Palette")
inactive_style := "c123456 BackgroundABCDEF"
active_style := "cABCDEF Background123456"
initialize_keyboard_gui()

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

<#+a::multi_tap("ĀÁǍÀÂÄÅⱭ")
<#a:: multi_tap("āáǎàâäåɑ")
<#+c::multi_tap("©ÇĈ")
<#c:: multi_tap("¢çĉ")
<#+e::multi_tap("ĒÉĚÈÊË")
<#e:: multi_tap("ēéěèêë")
<#+i::multi_tap("ĪÍǏÌÎÏ")
<#i:: multi_tap("īíǐìîïı")
<#+m::multi_tap("Ḿ")
<#m:: multi_tap("ḿ")
<#+n::multi_tap("ÑǸ")
<#n:: multi_tap("ñǹ")
<#+o::multi_tap("ŌÓǑÒÔÖ")
<#o:: multi_tap("ōóǒòôö")
<#+p::multi_tap("¶")
<#+s::multi_tap("§ŜŠẞ")
<#s:: multi_tap("ŝšßſ")
<#+u::multi_tap("ŪÚǓÙÛ")
<#u:: multi_tap("ūúǔùû")
<#+v::multi_tap("ÜǕǗǙǛ")
<#v:: multi_tap("üǖǘǚǜ")
<#+y::multi_tap("¥ŸŶ")
<#y:: multi_tap("ÿŷ")
<#+z::multi_tap("ẐŽ")
<#z:: multi_tap("ẑž")

~*RAlt:: {
	no_hold()
	Send "{Blind}{VKE8}"
	keyboard_update()
	keyboard_gui.Show("NA")
}
~*RAlt Up::{
	no_hold()
	keyboard_gui.Hide()
}
*>!Shift::
*>!Shift Up::{
	no_hold()
	keyboard_update()
}
>![::keyboard_update(Mod(keyboard_active_category + keyboard_data.Length - 2, keyboard_data.Length) + 1)
>!]::keyboard_update(Mod(keyboard_active_category, keyboard_data.Length) + 1)

#HotIf WinActive("ahk_exe LyX.exe")
^1::Send "{^}2{Right}"
^2::Send "\sqrt{Space}"
^/::Send "!mf"
^+/::Send "^+{Left}!mf{Down}"
#HotIf WinActive("ahk_exe Mathematica.exe")
^1::Send "^62{Right}"
#HotIf
#-::Send "–"
#[::Send "〖"
#]::Send "〗"

initialize_keyboard_gui() {
	global keyboard_buttons, keyboard_categories, keyboard_active_category
	key_width := 32
	key_height := 32
	keyboard_gui.MarginX := 0
	keyboard_gui.MarginY := 0
	keyboard_gui.SetFont("s16", "Source Sans Pro")
	keyboard_categories := []
	category_width := key_width * 15 // keyboard_data.Length
	For data in keyboard_data {
		keyboard_categories.Push(keyboard_gui.AddText(
			"x+0 y0 w" . category_width . " r1 Center " . inactive_style
		))
	}
	keyboard_buttons := [
		-1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
		-1.5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1.5,
		-1.75, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2.25,
		-2.25, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2.75,
		; -1.25, 1.25, 1.25, 6.25, 1.25, 1.25, 1.25, 1.25,
	]
	For index, width in keyboard_buttons {
		keyboard_buttons[index] := keyboard_gui.AddText(
			(width >= 0 ? "x+0 yp+0" : "x0 y+0")
			. " w" . key_width * Abs(width) . " h" . key_height
			. " Center Border +0x200 +0x80 " ; SS_CENTERIMAGE | SS_NOPREFIX
			. inactive_style
		)
	}
	keyboard_gui.Show("xCenter y" . key_height . " Hide")
	WinSetTransparent 192, keyboard_gui
	keyboard_active_category := 1
	keyboard_update()
	; Detect ahk_id instead of pure HWND so that hotkeys are only active while the window is visible.
	HotIfWinExist "ahk_id " . keyboard_gui.Hwnd
	hotkeys := Map(
		"VKC0", 1, "1", 2, "2", 3, "3", 4, "4", 5, "5", 6, "6", 7, "7", 8, "8", 9, "9", 10, "0", 11, "VKBD", 12, "VKBB", 13,
		"q", 16, "w", 17, "e", 18, "r", 19, "t", 20, "y", 21, "u", 22, "i", 23, "o", 24, "p", 25,
		"a", 30, "s", 31, "d", 32, "f", 33, "g", 34, "h", 35, "j", 36, "k", 37, "l", 38, "VKBA", 39, "VKDE", 40,
		"z", 43, "x", 44, "c", 45, "v", 46, "b", 47, "n", 48, "m", 49, "VKBC", 50, "VKBE", 51, "VKBF", 52,
	)
	For key, index in hotkeys {
		Hotkey ">!" . key, (index => (*) => button_keydown(index))(index)
		Hotkey ">!" . key . " Up", (index => (*) => button_keyup(index))(index)
	}
	HotIfWinExist
}

keyboard_update(index := keyboard_active_category) {
	global keyboard_active_category
	static default := [[
		"``", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "⌫",
		"⇤", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "◀", "▶", "U+",
		"⇬", "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'", "↵",
		"⇧", "z", "x", "c", "v", "b", "n", "m", ",", ".", "/", "⇧",
		"^", "⌘", "⌥", " ", "⌥", "⌘", "❖", "^",
	], [
		"~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", "⌫",
		"⇥", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "◁", "▷", "U+",
		"⇬", "A", "S", "D", "F", "G", "H", "J", "K", "L", ":", "`"", "↓",
		"⇧", "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?", "⇧",
		"^", "⌘", "⌥", " ", "⌥", "⌘", "❖", "^",
	]]
	keyboard_categories[keyboard_active_category].Opt(inactive_style)
	keyboard_categories[keyboard_active_category].Redraw()
	keyboard_active_category := index
	keyboard_categories[keyboard_active_category].Opt(active_style)
	keyboard_categories[keyboard_active_category].Redraw()
	shift := GetKeyState("LShift", "P") || GetKeyState("RShift", "P")
	For category in keyboard_categories {
		category.Text := keyboard_data[A_Index][shift + 1][-1]
	}
	For button in keyboard_buttons {
		button.Text := keyboard_data[index][shift + 1].Get(A_Index, default[shift + 1][A_Index])
	}
}

enable_blur(hWnd) {
	; WindowCompositionAttribute
	WCA_ACCENT_POLICY := 19

	; AccentState
	ACCENT_DISABLED := 0,
	ACCENT_ENABLE_GRADIENT := 1,
	ACCENT_ENABLE_TRANSPARENTGRADIENT := 2
	ACCENT_ENABLE_BLURBEHIND := 3
	ACCENT_INVALID_STATE := 4

	AccentPolicy := Buffer(16)
	NumPut("UInt", ACCENT_ENABLE_BLURBEHIND, AccentPolicy)

	WindowCompositionAttributeData := Buffer(A_PtrSize * 3)
	NumPut(
		"UPtr", WCA_ACCENT_POLICY,
		"UPtr", AccentPolicy.Ptr,
		"UPtr", AccentPolicy.Size,
		WindowCompositionAttributeData
	)

	DllCall("SetWindowCompositionAttribute", "Ptr", hWnd, "Ptr", WindowCompositionAttributeData.Ptr)
}

button_keydown(number) {
	SendText keyboard_buttons[number].Text
	keyboard_buttons[number].Opt(active_style)
	keyboard_buttons[number].Redraw()
}

button_keyup(number) {
	keyboard_buttons[number].Opt(inactive_style)
	keyboard_buttons[number].Redraw()
}

;-------------------------------------------------------------------------------
; Named symbols in HTML and (La)TeX
;-------------------------------------------------------------------------------

#Hotstring C O T
#Include html_entities.ahk
#Include latex.ahk

;-------------------------------------------------------------------------------
; Unicode search
;-------------------------------------------------------------------------------

unicode_data := Map()
unicode_gui := Gui("+ToolWindow -Theme", "Unicode Palette")
unicode_gui.SetFont("s12", "Source Sans Pro")
unicode_search := unicode_gui.AddEdit("w600")
unicode_list := unicode_gui.AddListView("w600 r16 -Multi -Hdr")
unicode_gui.AddButton("xm+240 w120 Default", "⎀").OnEvent("Click", on_unicode_submit)
initialize_unicode()

initialize_unicode() {
	f := FileRead("NamesList.txt")
	f := StrSplit(f, "C0 controls`n", , 2)[2]
	Loop Parse f, "`n" {
		If RegExMatch(A_LoopField, "^$|^@|^\t?;") {
			Continue
		} Else If RegExMatch(A_LoopField, "^[0-9A-F]{4,6}\t") {
			fields := StrSplit(A_LoopField, "`t", , 2)
			codepoint := Integer("0x" . fields[1])
			unicode_data[codepoint] := fields[2]
		} Else {
			unicode_data[codepoint] .= A_LoopField
		}
	}

	unicode_gui.OnEvent("Escape", (*) => unicode_gui.Hide())
	unicode_search.OnEvent("Change", (*) => unicode_update())
	unicode_list.InsertCol(1, "32")
	unicode_list.InsertCol(2, "72")
	unicode_list.InsertCol(3, "AutoHdr")
	unicode_list.OnEvent("DoubleClick", on_unicode_submit)
	unicode_update()
}

unicode_update() {
	needle := unicode_search.Text
	filtered := []
	Try {
		filtered.Push(Integer("0x" . needle))
	}
	Loop Parse needle {
		If Ord(A_LoopField) >= 128 {
			filtered.Push(Ord(A_LoopField))
		}
	}
	For codepoint, info in unicode_data {
		If needle == "" || InStr(info, needle, false) {
			filtered.Push(codepoint)
			If filtered.Length >= 16 {
				Break
			}
		}
	}

	unicode_list.Opt("-Redraw")
	unicode_list.Delete()
	For codepoint in filtered {
		If unicode_data.Has(codepoint) {
			unicode_list.Add(
				A_Index == 1 ? "Select Focus" : "",
				Chr(codepoint),
				Format("U+{:04X}", codepoint),
				unicode_data[codepoint],
			)
		}
	}
	unicode_list.Opt("+Redraw")
}

on_unicode_submit(*) {
	If unicode_list.GetNext() < 1 {
		Return
	}
	unicode_gui.Hide()
	SendText unicode_list.GetText(unicode_list.GetNext())
}

!\:: {
	unicode_gui.Show()
	unicode_search.Focus()
}
