let g:airline#themes#sats#palette = {}

let s:Mo = ["#331a1a", "#ffe0e0",       0,       7, "bold"]
let s:N1 = ["#1a2b33", "#85d7ff", s:Mo[2], s:Mo[3], "none"]
let s:N2 = [ s:N1[0] , "#c2ebff", s:N1[2], s:N1[3], "none"]
let s:N3 = [ s:N1[0] , "#e0f5ff", s:N2[2], s:N2[3], "none"]
let g:airline#themes#sats#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#sats#palette.normal_modified = {"airline_c": [s:N3[0], s:N3[1], s:N3[2], s:N3[3], s:Mo[4]]}

let s:I1 = ["#2d331a", "#dfff85", s:N3[2], s:N3[3], "none"]
let s:I2 = [ s:I1[0] , "#efffc2", s:I1[2], s:I1[3], "none"]
let s:I3 = [ s:I1[0] , "#f7ffe0", s:I2[2], s:I2[3], "none"]
let g:airline#themes#sats#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#sats#palette.insert_modified = {"airline_c": [s:I3[0], s:I3[1], s:I3[2], s:I3[3], s:Mo[4]]}
let g:airline#themes#sats#palette.insert_paste = {
\ "airline_a": [s:Mo[0], s:Mo[1], s:I1[2], s:N2[3], ""]}

let s:R1 = ["#332f1a", "#ffeb85", s:N1[2], s:N1[3], "none"]
let s:R2 = [ s:R1[0] , "#fff5c2", s:N1[2], s:N1[3], "none"]
let s:R3 = [ s:R1[0] , "#fffae0", s:N1[2], s:N1[3], "none"]
let g:airline#themes#sats#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#sats#palette.replace_modified = {"airline_c": [s:R3[0], s:R3[1], s:R3[2], s:R3[3], s:Mo[4]]}

let s:V1 = ["#2c1a33", "#df85ff", s:I3[2], s:I3[3], "none"]
let s:V2 = [ s:V1[0] , "#efc2ff", s:I3[2], s:V1[3], "none"]
let s:V3 = [ s:V1[0] , "#f7e0ff", s:V2[2], s:I3[3], "none"]
let g:airline#themes#sats#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#sats#palette.visual_modified = {"airline_c": [s:V3[0], s:V3[1], s:V3[2], s:V3[3], s:Mo[4]]}

let s:IA1 = ["#bbbbbb", "#eeeeee" , s:N3[2], s:V2[3], "none"]
let s:IA2 = [s:IA1[0] , s:IA1[1]  , s:V3[2], s:N1[3], "none"]
let s:IA3 = [s:IA2[0] , s:IA2[1]  , s:N2[2], s:V2[3], "none"]
let g:airline#themes#sats#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#sats#palette.inactive_modified = {"airline_c": [s:IA3[0], s:IA3[1], s:IA3[2], s:IA3[3], s:Mo[4]]}
