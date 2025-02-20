import re
import unicodedata

a = """[["``", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", unset,
unset, "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", unset, unset, unset,
unset, "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'", unset,
unset, "z", "x", "c", "v", "b", "n", "m", ",", ".", "/", "abc"],
["~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", unset,
unset, "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", unset, unset, unset,
unset, "A", "S", "D", "F", "G", "H", "J", "K", "L", ":", "`"", unset,
unset, "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?", "ABC"]],"""

style = "DOUBLE-STRUCK"


def f(ch: str) -> str:
    case = "CAPITAL" if ch.isupper() else "SMALL"
    try:
        return unicodedata.lookup(f"MATHEMATICAL {style} {case} {ch.upper()}")
    except KeyError:
        pass
    try:
        return unicodedata.lookup(f"{style} {case} {ch.upper()}")
    except KeyError:
        pass
    try:
        if ch.isdigit():
            z = "ZERO ONE TWO THREE FOUR FIVE SIX SEVEN EIGHT NINE".split()[int(ch)]
            return unicodedata.lookup(f"MATHEMATICAL {style} DIGIT {z}")
    except KeyError:
        pass
    return ""


print(re.sub(r'"`?\S"', lambda m: f'"{f(m.group(0)[-2])}"', a))
