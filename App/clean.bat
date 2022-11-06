@echo off
cd /d "%~dp0"

del /s ..\*.~*
del /s ..\*.bak
del /s *.cfg
del /s *.compiled
del /s *.dcu
del /s *.ddp
del /s *.dof
del /s *.drc
del /s *.dsk
del /s *.identcache
del /s *.local
del /s *.map
del /s *.mes
del /s *.mps
del /s *.mpt
del /s *.o
del /s *.ppu
del /s *.res
del /s *.rsj

for /d %%d in (*) do (
  rmdir /q "%%d\debug"
  rmdir /q "%%d\release"
  rmdir /q "%%d"
)

for /f "tokens=*" %%d in ('dir /b /ad /s "..\__history"')  do rmdir /q "%%d"
for /f "tokens=*" %%d in ('dir /b /ad /s "..\__recovery"') do rmdir /q "%%d"

for /f "tokens=*" %%d in ('dir /b /ad /s "..\backup"') do (
  del "%%d\*.bak"
  del "%%d\*.pas"
  del "%%d\*.dpr"
  rmdir /q "%%d"
)
