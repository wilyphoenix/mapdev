call E:\Games\FPS\ioUrT4_dev\q3ut4\maps\set_map_env_vars.bat

"%mapdir%\bsp.exe" -se %map%.bsp %map%.surface
"%mapdir%\surface_renewer.exe" %map%
"C:\Program Files\Windows NT\Accessories\wordpad.exe" %map%.surface

REM *** be sure to change the contents of the .surface files to reflect the new map name!!!
pause