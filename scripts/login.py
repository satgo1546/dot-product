import os
import time
import shutil

垃圾桶 = "/tmp/Downloads-shokeidai"

os.makedirs(垃圾桶, exist_ok=True)

def 扔():
    print("扔了", entry.path)
    try:
        shutil.move(entry.path, os.path.join(垃圾桶, entry.name))
    except Exception as e:
        print("失败！", e)

for entry in os.scandir(os.path.expanduser("~/Downloads")):
    存活天数 = int(time.time() - entry.stat().st_mtime) // 86400
    if entry.is_symlink():
        扔()
    elif entry.is_dir():
        if 存活天数 >= 7:
            扔()
    elif entry.is_file():
        if 存活天数 >= 3:
            扔()
    else:
        print("不是东西？！", entry.path)
