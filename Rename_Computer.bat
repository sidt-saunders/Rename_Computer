@ECHO OFF
SET ThisScriptsDirectory=\\USALPLATP01\DropBox\Sidt_Saunders\Scripts\Script_Files\Rename_Computer\
SET PowerShellScriptPath=%ThisScriptsDirectory%Rename_Computer.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%PowerShellScriptPath%""' -Verb RunAs}";