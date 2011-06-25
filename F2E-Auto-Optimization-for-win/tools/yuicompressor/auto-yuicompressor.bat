@echo off
::设置g h i j k l m

::检查Java环境
if "%JAVA_HOME%" == "" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\native2ascii.exe" goto NoJavaHome

::计算css文件个数及其大小
set cTotalFiles=0
for /r %build_path% %%g in (*.css) do (
    set /a cTotalFiles+=1  
)

set cTotalBytes=0
for /r %build_path% %%h in (*.css) do (
    set /a cTotalBytes =cTotalBytes+%%~zh
)
set /a cTotalKB = cTotalBytes/1024

echo 该目录下总共有%cTotalFiles%个css文件,总大小为%cTotalKB%KB

::开始压缩css
for /r %build_path% %%i in (*.css) do (
    "%JAVA_HOME%\bin\java.exe" -jar "%yuicompressor_path%" --charset UTF-8 "%%i" -o "%%~pi%%~ni-min%%~xi"
)


::压缩后大小计算
set jTotalBytesOut=0
for /r %build_path% %%j in (*-min.css) do (
    set /a cTotalBytesOut=cTotalBytesOut+%%~zj
)
set /a cSaveing=(cTotalBytes-cTotalBytesOut)/1024
set /a cTotalBytesOutKB =cTotalBytesOut/1024
set /a cRatio=(cTotalBytesOut*100/cTotalBytes)

echo 压缩成功，总共压缩了 %cTotalFiles% 个文件
echo 压缩后文件大小 %cTotalBytesOutKB% KB，节省了 %cSaveing% KB，压缩率为 %cRatio%%%

goto yuicompressor-end


:NoJavaHome
echo.
echo **** 请先安装 JDK 并设置 JAVA_HOME 环境变量
echo.

:yuicompressor-end