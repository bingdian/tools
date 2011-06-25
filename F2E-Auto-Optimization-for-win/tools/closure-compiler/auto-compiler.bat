@echo off
::设置a b c d e f

::检查Java环境
if "%JAVA_HOME%" == "" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\native2ascii.exe" goto NoJavaHome

::计算js文件个数及其大小
set jTotalFiles=0
for /r %build_path% %%a in (*.js) do (
    set /a jTotalFiles+=1  
)

set jTotalBytes=0
for /r %build_path% %%b in (*.js) do (
    set /a jTotalBytes =jTotalBytes+%%~zb
)
set /a jTotalKB = jTotalBytes/1024

echo 该目录下总共有%jTotalFiles%个js文件,总大小为%jTotalKB%KB

::开始压缩js
for /r %build_path% %%c in (*.js) do (
    "%JAVA_HOME%\bin\java.exe" -jar "%closure_compiler_path%"  --compilation_level SIMPLE_OPTIMIZATIONS --charset UTF-8 --js "%%c" --js_output_file "%%~pc%%~nc-min%%~xc"
)

::生成文件输出对比
::for /r %build_path% %%e in (*.js) do (
::    echo %%~se----------------------%%~ze
::)

::压缩后大小计算
set jTotalBytesOut=0
for /r %build_path% %%d in (*-min.js) do (
    set /a jTotalBytesOut=jTotalBytesOut+%%~zd
)
set /a jSaveing=(jTotalBytes-jTotalBytesOut)/1024
set /a jTotalBytesOutKB =jTotalBytesOut/1024
set /a jRatio=(jTotalBytesOut*100/jTotalBytes)

echo 压缩成功，总共压缩了 %jTotalFiles% 个文件
echo 压缩后文件大小 %jTotalBytesOutKB% KB，节省了 %jSaveing% KB，压缩率为 %jRatio%%%

goto closure-compiler-end


:NoJavaHome
echo.
echo **** 请先安装 JDK 并设置 JAVA_HOME 环境变量
echo.

:closure-compiler-end