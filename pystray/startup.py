import os
import sys
import time
import threading
import webbrowser
import subprocess
from tkinter import messagebox
from flask import Flask, request, send_from_directory
from PIL import Image
import pystray



os.chdir(os.path.dirname(__file__))

app = Flask(__name__)


@app.route("/")
def index():
    return "114514"


@app.route("/c/<path:path>")
def serve_c(path):
    return send_from_directory("C:\\", path)


@app.route("/wsl/<path:path>")
def serve_wsl(path):
    return send_from_directory(r"\\wsl.localhost\Arch", path)


@app.route("/write", methods=["GET", "POST"])
def write_file():
    if "file" not in request.files:
        return "No file part", 400
    file = request.files["file"]
    if file.filename == "":
        return "No selected file", 400
    file.save(os.path.join("C:\\", file.filename))
    return "File uploaded successfully", 200


def reload_script():
    tray.stop()
    subprocess.Popen([sys.executable, *sys.argv], start_new_session=True, creationflags=subprocess.DETACHED_PROCESS)
    os._exit(114)
    os.execv(sys.executable, ["python"] + sys.argv)

time.sleep(0.5)
server=threading.Thread(target=lambda: app.run(host="::1", port=1546))
server.start()

tray = pystray.Icon(
    "satgo_pystray",
    Image.open("icon.png"),
    "localhost:1546",
    pystray.Menu(
        pystray.MenuItem("打开仪表盘(&O)", lambda: webbrowser.open('http://localhost:1546/'), default=True),
        pystray.MenuItem("显示消息框", lambda:messagebox.showinfo("标题", f"正文")),
        pystray.MenuItem("重新加载脚本(&R)", reload_script),
        pystray.MenuItem("退出(&X)", lambda: (tray.stop(), os._exit(114))),
    ),
)
tray.run()
