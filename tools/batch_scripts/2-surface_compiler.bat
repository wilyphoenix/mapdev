call E:\Games\FPS\ioUrT4_dev\q3ut4\maps\set_map_env_vars.bat

copy /Y "%MAPDIR%\%MAP%.surface" "%MAPDIR%\%MAP%.surface.current"
"%MAPDIR%\bsp.exe" -si %MAP%.bsp %MAP%.surface
