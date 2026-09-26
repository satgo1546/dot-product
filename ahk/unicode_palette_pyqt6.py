#!/usr/bin/env python3
import os
import re
import sys
import subprocess
from zipfile import ZipFile

import lxml.etree
from PySide6.QtCore import ClassInfo, QEvent, Qt, Slot
from PySide6.QtDBus import QDBusConnection
from PySide6.QtGui import QIcon
from PySide6.QtWidgets import (
    QAbstractItemView,
    QApplication,
    QDialog,
    QDialogButtonBox,
    QHeaderView,
    QLineEdit,
    QTableWidget,
    QTableWidgetItem,
    QVBoxLayout,
)

os.chdir(os.path.dirname(os.path.abspath(__file__)))

# adapted from https://pip.wtf/
t = os.path.abspath(".pip_wtf." + os.path.basename(__file__))
sys.path = [p for p in sys.path if "-packages" not in p] + [t]
os.environ["PATH"] = t + os.path.sep + "bin" + os.pathsep + os.environ["PATH"]
os.environ["PYTHONPATH"] = os.pathsep.join(sys.path)
if not os.path.exists(t):
    subprocess.run([sys.executable, "-m", "pip", "install", "-t", t, "frizbee==0.13.0"], check=True)

import frizbee

DIR = os.path.expanduser("~/.cache/pystray")
os.makedirs(DIR, exist_ok=True)
if not os.path.exists(DIR + "/UCD.zip"):
    subprocess.run(["aria2c", "--dir", DIR, "https://www.unicode.org/Public/latest/ucd/UCD.zip"], check=True)

with ZipFile(DIR + "/UCD.zip") as zip:
    with zip.open("UnicodeData.txt") as f:
        f = f.read().decode()
    unicode_data = {}
    for line in f.splitlines():
        fields = line.split(';')
        fields.append(fields[1])
        unicode_data[int(fields[0], 16)] = fields

    with zip.open('NamesList.txt') as f:
        f = f.read().decode()
_, _, f = f.partition("C0 controls\n")
codepoint = None
for line in f.splitlines():
    if re.match(r"$|@|\t?;|\t[x~#] ", line):
        continue
    if re.match(r"[0-9A-F]{4,6}\t", line):
        codepoint, _, name = line.partition("\t")
        codepoint = int(codepoint, 16)
    elif codepoint in unicode_data:
        unicode_data[codepoint][-1] += " " + line.lstrip('\t')


if not os.path.exists(DIR + "/unicode.xml"):
    # https://www.w3.org/TR/xml-entity-names/
    subprocess.run(["aria2c", "--dir", DIR, "https://github.com/w3c/xml-entities/raw/refs/heads/gh-pages/unicode.xml"], check=True)

for character in lxml.etree.parse(DIR + "/unicode.xml").iterfind('./charlist/character'):
    codepoint = character.attrib["dec"]
    if not codepoint.isdigit():
        continue
    codepoint = int(codepoint)
    data = unicode_data.get(codepoint)
    if data is None:
        continue
    for node in character:
        if not node.text:
            continue
        if node.tag in ("latex", "varlatex", "mathlatex", "AMS"):
            data[-1] += " " + node.text.rstrip()
        elif node.tag == "Wolfram":
            data[-1] += f" \\[{node.text}]"

codepoint_list = list(unicode_data.keys())
haystacks = frizbee.Haystacks(x[-1] for x in unicode_data.values())


@ClassInfo(**{"D-Bus Interface": "e.e"})
class UnicodePalette(QDialog):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Unicode Palette")
        self.setWindowFlag(Qt.WindowType.Tool)
        self.resize(600, 600)

        layout = QVBoxLayout(self)
        self.search = QLineEdit()
        self.table = QTableWidget(0, 3)
        self.table.horizontalHeader().setVisible(False)
        self.table.verticalHeader().setVisible(False)
        self.table.setSelectionBehavior(QAbstractItemView.SelectionBehavior.SelectRows)
        self.table.setSelectionMode(QAbstractItemView.SelectionMode.SingleSelection)
        self.table.setEditTriggers(QAbstractItemView.EditTrigger.NoEditTriggers)
        self.table.horizontalHeader().setSectionResizeMode(0, QHeaderView.ResizeMode.Fixed)
        self.table.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeMode.Fixed)
        self.table.horizontalHeader().setSectionResizeMode(2, QHeaderView.ResizeMode.Stretch)
        self.table.setColumnWidth(0, 72)
        self.table.setColumnWidth(1, 90)

        #font = QFont("Source Sans Pro", 10)
        #self.table.setFont(font)
        #self.search.setFont(font)

        buttons = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel)
        buttons.accepted.connect(self.submit)
        buttons.rejected.connect(self.hide)

        layout.addWidget(self.search)
        layout.addWidget(self.table)
        layout.addWidget(buttons)

        self.search.installEventFilter(self)
        self.search.textChanged.connect(self.update_table)
        self.search.returnPressed.connect(self.submit)
        self.table.cellDoubleClicked.connect(self.submit)

        self.update_table()

    def eventFilter(self, obj, event):
        if (
            event.type() == QEvent.Type.KeyPress
            and event.modifiers() == Qt.KeyboardModifier.NoModifier
            and event.key() in (Qt.Key.Key_Up, Qt.Key.Key_Down)
            and self.table.rowCount()
        ):
            self.table.selectRow((self.table.currentRow() + (event.key() == Qt.Key.Key_Down) - (event.key() == Qt.Key.Key_Up)) % self.table.rowCount())
            return True
        return super().eventFilter(obj, event)

    def update_table(self):
        needle = self.search.text()
        filtered = []

        try:
            codepoint = int(needle, 16)
            if 0 <= codepoint < 0x110000:
                filtered.append(codepoint)
        except ValueError:
            pass

        for ch in needle:
            o = ord(ch)
            if o < 32 or o >= 128:
                filtered.append(o)

        for match in frizbee.Matcher.from_query(needle, max_items=16 - len(filtered)).match_list(haystacks):
            filtered.append(codepoint_list[match.index])

        self.table.setRowCount(0)
        self.table.setRowCount(len(filtered))
        for i, codepoint in enumerate(filtered):
            char = chr(codepoint)
            data = unicode_data.get(codepoint) or "?????????????????"
            if data[2][0] == "M":
                char = '◌' + char
            self.table.setItem(i, 0, QTableWidgetItem(char))
            self.table.setItem(i, 1, QTableWidgetItem(f"U+{codepoint:04X}"))
            self.table.setItem(i, 2, QTableWidgetItem(data[-1]))
        if filtered:
            self.table.selectRow(0)

    def get_selected_character(self):
        i = self.table.currentRow()
        if i < 0:
            return ""
        item = self.table.item(i, 1)
        if item is None:
            return ""
        return ''.join(chr(int(x, 16)) for x in item.text().split("U+") if x)

    def submit(self, *_):
        if c := self.get_selected_character():
            self.hide()
            c = "".join(f"\\U{ord(c):08x}" for c in c)
            subprocess.Popen(f"sleep .016; echo -ne '{c}' > $XDG_RUNTIME_DIR/fcitx5-pipe-to-type", shell=True, start_new_session=True)
            # QApplication.clipboard().setText(c)

    @Slot()
    def Show(self):
        self.show()
        self.showNormal()
        self.raise_()
        self.activateWindow()
        self.search.setFocus()
        self.search.selectAll()

    @Slot()
    def Quit(self):
        QApplication.quit()

app = QApplication(sys.argv)
app.setQuitOnLastWindowClosed(False)
app.setWindowIcon(QIcon("icon.png"))
window = UnicodePalette()
session_bus = QDBusConnection.sessionBus()
if not session_bus.registerService("io.github.satgo1546.UnicodePalette"):
    sys.exit(1)
session_bus.registerObject("/window", window, QDBusConnection.RegisterOption.ExportAllSlots)
sys.exit(app.exec())

# dbus-send --session --print-reply --dest=io.github.satgo1546.UnicodePalette /window e.e.Show
