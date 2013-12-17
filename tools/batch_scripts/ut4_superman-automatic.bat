call E:\Games\FPS\ioUrT4_dev\q3ut4\maps\set_map_env_vars.bat
call %mapdir%\clear_compile_logs.bat

REM BSP
"%q3map2%" -fs_basepath "%urtdir%" -fs_game "q3ut4" -game "q3ut4" -meta -v "%mapdir%\%map%.map" > "%logdir%\%map%_compile_bsp.txt"

REM VIS
"%q3map2%" -fs_basepath "%urtdir%" -fs_game "q3ut4" -game "q3ut4" -vis -hint -saveprt -v -threads %threads% "%mapdir%\%map%.map" > "%logdir%\%map%_compile_vis.txt"

REM LIGHT
"%q3map2%" -fs_basepath "%urtdir%" -fs_game "q3ut4" -game "q3ut4" -light -gamma 1.1 -compensate 1.1 -export -fast -patchshadows -v -lomem -bounce 16 -samplesize 8 -samples 4 -filter -super 3 -threads %threads% "%mapdir%\%map%.map" > "%logdir%\%map%_compile_light.txt"

REM AAS
"%bspc%" -bsp2aas "%mapdir%\%map%.bsp" -forcesidesvisible -optimize -breadthfirst -threads %threads% > "%map%_compile_aas.txt"

REM SURFACE
type "%mapdir%\1-surface_definitions.txt"
REM "%mapdir%\1-surface_generator.bat"
"%mapdir%\2-surface_compiler.bat"
