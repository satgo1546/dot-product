@echo off
rem HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\AutoRun (REG_SZ)
rem HKEY_CURRENT_USER\Software\Microsoft\Command Processor\AutoRun (REG_EXPAND_SZ)
setlocal
prompt $+$P$G$S
doskey gcc=clang --target=i686-w64-mingw32 -Wall -Wextra -Wno-unused-parameter $*
doskey g++=clang++ --target=i686-w64-mingw32 -Wall -Wextra -Wno-unused-parameter -D__STRICT_ANSI__ $*
