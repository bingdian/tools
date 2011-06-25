@echo off
::����a b c d e f

::���Java����
if "%JAVA_HOME%" == "" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\native2ascii.exe" goto NoJavaHome

::����js�ļ����������С
set jTotalFiles=0
for /r %build_path% %%a in (*.js) do (
    set /a jTotalFiles+=1  
)

set jTotalBytes=0
for /r %build_path% %%b in (*.js) do (
    set /a jTotalBytes =jTotalBytes+%%~zb
)
set /a jTotalKB = jTotalBytes/1024

echo ��Ŀ¼���ܹ���%jTotalFiles%��js�ļ�,�ܴ�СΪ%jTotalKB%KB

::��ʼѹ��js
for /r %build_path% %%c in (*.js) do (
    "%JAVA_HOME%\bin\java.exe" -jar "%closure_compiler_path%"  --compilation_level SIMPLE_OPTIMIZATIONS --charset UTF-8 --js "%%c" --js_output_file "%%~pc%%~nc-min%%~xc"
)

::�����ļ�����Ա�
::for /r %build_path% %%e in (*.js) do (
::    echo %%~se----------------------%%~ze
::)

::ѹ�����С����
set jTotalBytesOut=0
for /r %build_path% %%d in (*-min.js) do (
    set /a jTotalBytesOut=jTotalBytesOut+%%~zd
)
set /a jSaveing=(jTotalBytes-jTotalBytesOut)/1024
set /a jTotalBytesOutKB =jTotalBytesOut/1024
set /a jRatio=(jTotalBytesOut*100/jTotalBytes)

echo ѹ���ɹ����ܹ�ѹ���� %jTotalFiles% ���ļ�
echo ѹ�����ļ���С %jTotalBytesOutKB% KB����ʡ�� %jSaveing% KB��ѹ����Ϊ %jRatio%%%

goto closure-compiler-end


:NoJavaHome
echo.
echo **** ���Ȱ�װ JDK ������ JAVA_HOME ��������
echo.

:closure-compiler-end