import os
import re
import sys
import time
import threading
import webbrowser
import subprocess
import unicodedata
import urllib.parse
from tkinter import messagebox
from flask import Flask, request, send_from_directory
from PIL import Image
import requests
import pystray


os.chdir(os.path.dirname(__file__))

app = Flask(__name__, subdomain_matching=True)
app.config["SERVER_NAME"] = "localhost:1546"


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
        return "file needed", 400
    file = request.files["file"]
    if file.filename == "":
        return "filename needed", 400
    file.save(os.path.join("C:\\", file.filename))
    return f"done writing <tt>{file.filename}</tt>"


subdomains: dict[str, str] = {}


@app.route("/", subdomain="<subdomain>")
@app.route("/<path:path>", subdomain="<subdomain>")
def serve_dir(subdomain, path=""):
    if not path or path.endswith("/"):
        path += "index.html"
    print(subdomain, subdomains.get(subdomain), path)
    if subdomain not in subdomains:
        return f"unknown subdomain <tt>{subdomain}</tt>"
    return send_from_directory(subdomains[subdomain], path)


def slugify(x: str) -> str:
    x = unicodedata.normalize("NFKD", x)
    x = re.sub(r"[^A-Za-z0-9]", "-", x).strip("-").lower()
    x = re.sub(r"-+", "-", x)
    return x


@app.route("/open")
def open_subdomain():
    path = request.args.get("path")
    if not path:
        return "path needed", 400
    dirname, filename = os.path.split(path)
    subdomain = slugify(os.path.basename(dirname))
    while dirname != subdomains.get(subdomain) != None:
        subdomain += "-copy"
    subdomains[subdomain] = dirname
    webbrowser.open(f"http://{subdomain}.localhost:1546/{urllib.parse.quote(filename)}")
    return f"""allocated subdomain: {subdomain},
        serving {dirname},
        opening /{filename}"""


def reload_script():
    tray.stop()
    subprocess.Popen(
        [sys.executable, *sys.argv],
        start_new_session=True,
        creationflags=subprocess.DETACHED_PROCESS,
    )
    os._exit(114)
    os.execv(sys.executable, ["python"] + sys.argv)


if len(sys.argv) > 1:
    for path in sys.argv[1:6]:
        requests.get("http://localhost:1546/open", {"path": path}, timeout=1)
    exit()

time.sleep(0.5)
server = threading.Thread(target=lambda: app.run(host="::1", port=1546))
server.start()

tray = pystray.Icon(
    "satgo_pystray",
    Image.open("icon.png"),
    "localhost:1546",
    pystray.Menu(
        pystray.MenuItem(
            "打开仪表盘(&O)",
            lambda: webbrowser.open("http://localhost:1546/"),
            default=True,
        ),
        pystray.MenuItem("显示消息框", lambda: messagebox.showinfo("标题", f"正文")),
        pystray.MenuItem("重新加载脚本(&R)", reload_script),
        pystray.MenuItem("退出(&X)", lambda: (tray.stop(), os._exit(114))),
    ),
)
tray.run()
