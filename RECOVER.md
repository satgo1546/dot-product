Recovering
==========

| □…                 | … = □             |
| ------------------ | ----------------- |
| `$XDG_CONFIG_HOME` | ~/.config         |
| `$XDG_DATA_HOME`   | ~/.local/share    |

```bash
basename $(pwd) # dot-product
ln -s $(pwd)/bashrc ~/.bashrc
ln -s $(pwd)/bash_profile ~/.bash_profile
ln -s $(pwd)/vimrc ~/.vimrc
```

```
.config/fontconfig -> ./fontconfig
.vim -> ./vim
.theme/Packed Ice Theme -> [satgo1546/packed-ice-theme][1]

(copy) C:\Windows\Fonts -> ~/.local/share/fonts
```

[1]: https://github.com/satgo1546/packed-ice-theme
