#!/usr/bin/env python3
import os
import re
import sys
import subprocess

from PySide6.QtCore import ClassInfo, Qt, Slot
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


def load_unicode_data():
    data = {}
    with open("NamesList.txt", encoding="utf-8") as f:
        f = f.read()
    _, _, f = f.partition("C0 controls\n")
    codepoint = None
    for line in f.splitlines():
        if re.match(r"$|@|\t?;|\tx ", line):
            continue
        if re.match(r"[0-9A-F]{4,6}\t", line):
            parts = line.split("\t", 1)
            codepoint = int(parts[0], 16)
            data[codepoint] = parts[1]
        elif codepoint is not None:
            data[codepoint] += re.sub(r"^\t", " ", line)
    return data


@ClassInfo(**{"D-Bus Interface": "e.e"})
class UnicodePalette(QDialog):
    def __init__(self):
        super().__init__()
        self.data = load_unicode_data()
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

        self.search.textChanged.connect(self.update_table)
        self.search.returnPressed.connect(self.submit)
        self.table.cellDoubleClicked.connect(self.submit)

        self.update_table()

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

        for codepoint, info in self.data.items():
            if needle.casefold() in info.casefold():
                filtered.append(codepoint)
                if len(filtered) >= 16:
                    break

        self.table.setRowCount(0)
        self.table.setRowCount(len(filtered))
        for i, codepoint in enumerate(filtered):
            self.table.setItem(i, 0, QTableWidgetItem(chr(codepoint)))
            self.table.setItem(i, 1, QTableWidgetItem(f"U+{codepoint:04X}"))
            self.table.setItem(i, 2, QTableWidgetItem(self.data.get(codepoint, "???")))
        if filtered:
            self.table.selectRow(0)

    def get_selected_character(self):
        i = self.table.currentRow()
        if i < 0:
            return ""
        item = self.table.item(i, 0)
        if item is None:
            return ""
        return item.text()

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

# gdbus call --session --dest io.github.satgo1546.UnicodePalette --object-path /window --method e.e.Show
