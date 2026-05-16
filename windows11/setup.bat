@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "& {
    $userfolder = $env:USERPROFILE
    $setupdir = Join-Path $userfolder 'git\ErraticPattern\windows11'
    $wallpaper = Join-Path $setupdir 'common\wallpaper.png'
    $setupjson = Join-Path $setupdir 'windows11\winutil_setup.json'

    # Add wallpaper
    Add-Type -TypeDefinition @'
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport(""user32.dll"", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
'@
    [Wallpaper]::SystemParametersInfo(20, 0, $wallpaper, 0x01 | 0x02)

    # Download and run WinUtil with config
    Invoke-WebRequest -Uri 'https://christitus.com/win' -OutFile '$env:TEMP\winutil.ps1'
    & '$env:TEMP\winutil.ps1' -Config $setupjson
}"