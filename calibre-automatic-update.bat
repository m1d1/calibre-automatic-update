@echo off
:: --- calibre-automatic-update.bat
:: --- 20170717 - Calibre 4 Version, Chalid El-Heliebi - ALLESebook.de (https://allesebook.de/calibre/calibre-automatisch-herunterladen-und-aktualisieren-windows/)
:: --- 20201003 - Calibre 5 Version by m1d1

:: User Settings 
SET Version=1  		:: Calibre Version :: 0 = 32 Bit, 1 = 64 Bit (64 Bit System)
SET Silent=1   		:: Installation :: 0 = regular installation, 1 = silent, no confirm

:: Do not change this 
SET SilentEcho=still
SET Silent=/qb
SET VersionEcho=64-bit
SET Version=win64
IF %Silent%==0 (
	SET SilentEcho=normal
	SET Silent=
)

IF %Version%==0 (
	SET VersionEcho=32-bit
	SET Version=win32	
)

calibre-debug.exe -c "import urllib.request;import ssl;from calibre.constants import numeric_version; ctx=ssl._create_unverified_context();raise SystemExit(int(numeric_version  < (tuple(map(int, urllib.request.urlopen('http://calibre-ebook.com/downloads/latest_version', context=ctx).read().decode(encoding = 'UTF-8').split('.'))))))"
if %ERRORLEVEL%==0 (
  echo Calibre is uptodate
) else (
  :Install
  echo upgrading calibre, please wait.
  calibre.exe --shutdown-running-calibre
  msiexec /i http://status.calibre-ebook.com/dist/%Version% %Silent%
)
exit