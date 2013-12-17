call E:\Games\FPS\ioUrT4_dev\q3ut4\maps\set_map_env_vars.bat

@echo off
REM Copy your maps' patch group into a new .map file, surround the patches in a caulk hull (like a skybox of caulk),
REM save this as a .map, then specify the .map name in the MODEL variable below. See set_map_env_vars.bat to make sure
REM the rest of the path variables get set. Check this link for more details.
REM http://en.wikibooks.org/wiki/Q3Map2#Creating_an_.ase_model_out_of_brushwork
@echo on


set MODEL=woi

REM BSP CONVERT
%q3map2% -fs_basepath "%urtdir%" -fs_game "q3ut4" -game "q3ut4" -meta -patchmeta -v "%mapdir%\%map%-models_%model%.map"
%q3map2% -fs_basepath "%urtdir%" -fs_game "q3ut4" -game "q3ut4" -convert -v "%mapdir%\%map%-models_%model%.bsp"

mkdir ..\models\mapobjects\%map%
move %map%-models_%model%.ase ..\models\mapobjects\%map%\%model%.ase

pause