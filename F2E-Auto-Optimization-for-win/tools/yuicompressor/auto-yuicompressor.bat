@echo off
::����g h i j k l m

::���Java����
if "%JAVA_HOME%" == "" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto NoJavaHome
if not exist "%JAVA_HOME%\bin\native2ascii.exe" goto NoJavaHome

::����css�ļ����������С
set cTotalFiles=0
for /r %build_path% %%g in (*.css) do (
    set /a cTotalFiles+=1  
)

set cTotalBytes=0
for /r %build_path% %%h in (*.css) do (
    set /a cTotalBytes =cTotalBytes+%%~zh
)
set /a cTotalKB = cTotalBytes/1024

echo ��Ŀ¼���ܹ���%cTotalFiles%��css�ļ�,�ܴ�СΪ%cTotalKB%KB

::��ʼѹ��css
for /r %build_path% %%i in (*.css) do (
    "%JAVA_HOME%\bin\java.exe" -jar "%yuicompressor_path%" --charset UTF-8 "%%i" -o "%%~pi%%~ni-min%%~xi"
)


::ѹ�����С����
set jTotalBytesOut=0
for /r %build_path% %%j in (*-min.css) do (
    set /a cTotalBytesOut=cTotalBytesOut+%%~zj
)
set /a cSaveing=(cTotalBytes-cTotalBytesOut)/1024
set /a cTotalBytesOutKB =cTotalBytesOut/1024
set /a cRatio=(cTotalBytesOut*100/cTotalBytes)

echo ѹ���ɹ����ܹ�ѹ���� %cTotalFiles% ���ļ�
echo ѹ�����ļ���С %cTotalBytesOutKB% KB����ʡ�� %cSaveing% KB��ѹ����Ϊ %cRatio%%%

goto yuicompressor-end


:NoJavaHome
echo.
echo **** ���Ȱ�װ JDK ������ JAVA_HOME ��������
echo.

:yuicompressor-end