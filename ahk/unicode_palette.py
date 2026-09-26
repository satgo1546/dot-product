import re
import os
import unicodedata
from zipfile import ZipFile


DIR = os.path.expanduser("~/.cache/pystray")

with ZipFile(DIR + "/UCD.zip") as zip:
    unicode_data = {}
    with zip.open("UnicodeData.txt") as f:
        f = f.read().decode()
    for line in f.splitlines():
        fields = line.split(';')
        unicode_data[int(fields[0], 16)] = fields

    with zip.open('NamesList.txt') as f:
        f = f.read().decode()
    _, _, f = f.partition("C0 controls\n")
    codepoint = None
    lines = []
    for line in f.splitlines():
        if line == "" or line.startswith("@") or re.match(r"\t?;", line) or re.match(r"\tx ", line):
            continue
        elif re.match(r"^[0-9A-F]{4,6}\t", line):
            codepoint, _, name = line.partition("\t")
            codepoint = int(codepoint, 16)
            char = chr(codepoint)
            if codepoint in unicode_data:
                if unicode_data[codepoint][2][0] == "C":
                    codepoint = None
                    continue
                elif unicode_data[codepoint][2][0] == "M":
                    char = "◌" + char
            lines.append(f"{codepoint:04X}\t{char}\t{name}\t")
        elif codepoint is not None:
            #lines[-1] += line
            lines[-1] += " " + line.lstrip('\t')
            pass
    with open(DIR + "/names.txt", 'w') as f:
        print('\n'.join(lines), file=f)
