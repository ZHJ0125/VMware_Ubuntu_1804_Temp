@echo off
@chcp 65001
:: 虚拟机压缩包正确的MD5哈希值
set TRUEHASH=A611BA8A9B78162A54DD0DE1FB966661
set PackageFileName=VMware_Ubuntu1804_Temp.rar

:: 欢迎使用 VMware_Ubuntu_18.04 虚拟机压缩包
:: 虚拟机压缩包内置了一些开发中常用的软件,包括VSCode、Chrome、搜狗中文输入法等
echo ==============================================================
echo  Welcome to the VMware_Ubuntu_18.04 virtual machine package!
echo --------------------------------------------------------------
echo  * Function: This script is used to calculate the hash value
echo    of a virtual machine package to verify its integrity.
echo  * Download Link: https://www.aliyundrive.com/s/RiETdvXSvMb
echo  * Contact: https://github.com/ZHJ0125
echo  * Version: V0.1-20220205
echo ==============================================================

:: 修改文件名
if not exist %PackageFileName% (
    if exist VMware_Ubuntu1804_Temp.txt (
        ren VMware_Ubuntu1804_Temp.txt %PackageFileName%
    ) else (
        echo.& echo Error: %PackageFileName% not exist!!!!
        echo.& echo Please download the %PackageFileName% first!!
        echo.& pause
    )
)
echo.& echo %PackageFileName% is ready!

:: 哈希值计算
echo.& echo The correct hash value: %TRUEHASH%
echo.& echo HASH Calculating, takes about 15 seconds.....
echo (If there is no response for a long time, click Enter)
powershell -C "Get-FileHash ./VMware_Ubuntu1804_Temp.rar -Algorithm MD5" >> tempFile
for /f "delims=" %%i in ('type tempFile') do set temp=%%i
set HASH=%temp:~16,48%
echo.& echo The computed hash value: %HASH%

:: 哈希值比较
echo.& echo.& if %TRUEHASH% == %HASH% (
    echo ==========================================================
    echo Result: Success √
    echo ----------------------------------------------------------
    echo Congratulations, the file verification is correct!
    echo Then, Unzip this package, open it in VMware, and use it!
    echo ==========================================================
    del tempFile
) else (
    echo ==========================================================
    echo Result: Error ×
    echo ----------------------------------------------------------
    echo The file validation is incorrect!!
    echo Check the tempFile or re-download the compressed package..
    echo ==========================================================
)

echo.& echo.& pause
exit
