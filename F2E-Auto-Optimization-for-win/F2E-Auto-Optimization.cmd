@echo off
color 03
set VersionText=(v0.1)
title -ǰ�˿����Զ����Ż�ƽ̨-%VersionText%

echo ��ʼ���� %date% %time% -  %VersionText%.
echo ���ߣ���Զ�ı���
echo Email��imbingdian@gmail.com
echo ˵�������������ǰ���Զ����Ż�������ʵ�ֶ�css��js���﷨����ѹ������ͼƬ��
echo ����ѹ����
echo.
echo.

echo **** ǰ�˿����Զ����Ż�ƽ̨ ****
::%~dp0
echo.
echo.
set closure_compiler_path=%~dp0tools\closure-compiler\compiler.jar
set yuicompressor_path=%~dp0tools\yuicompressor\yuicompressor-2.4.6.jar
set jpegtran_path=%~dp0tools\jpegtran\jpegtran.exe
set pngout_path=%~dp0tools\pngout\pngout.exe
set gifsicle_path=%~dp0tools\gifsicle\gifsicle.exe


::����Ŀ¼---------------------------------------------------------------------
echo ������Ҫ�������Ŀ�ļ���Ŀ¼�����磺d:\wwwroot\F2E,Ŀ¼���������\��
echo ��ȷ����Ŀ�ļ����´�����Ŀ¼��
echo -src Դ��
echo -build ���ļ���
echo.
set /p project_path=������:
set src=\src
set build=\build
set src_path=%project_path%%src%
set build_path=%project_path%%build%
echo.
echo �������Ŀ¼��: %project_path%
echo ��Ҫ�Ż���Ŀ¼�ǣ�%src_path%
echo �Ż����Ŀ¼�ǣ�%build_path%
echo.
echo.
::ȷ����ʾ
:choice
echo �Ƿ�ȷ���Ż�����Ŀ��
echo Y:ȷ��
echo N:�˳�
set /p choice=��ѡ��:
IF NOT "%choice%"=="" SET choice=%choice:~0,1%
if /i "%choice%"=="y" goto start
if /i "%choice%"=="n" goto end
echo ѡ����Ч,����������!
echo.
goto choice
@echo off

:start
echo.
echo.

::�������buildĿ¼�����buildĿ¼
if exist %build_path% goto rd_build_path
:rd_build_path
rd /s /q %build_path%
md %build_path%
goto copy_to_build

::�����ļ���buildĿ¼-----------------------------------------------------------
:copy_to_build
echo ��ʼ�Ż�����......
xcopy /e /q /y %src_path% %build_path%
echo �Ż��ļ�Ŀ¼�������


::��Ŀ¼�е�js��Google Closure Compiler������֤---------------------------------
echo.
echo.
echo ��ʼѹ��js......
call %~dp0tools\closure-compiler\auto-compiler.bat
echo jsѹ�����


::ѹ��css-----------------------------------------------------------------------
echo.
echo.
echo ��ʼѹ��css......
call %~dp0tools\yuicompressor\auto-yuicompressor.bat
echo cssѹ�����

::ѹ��jpg---------------------------------------------------------------------
echo.
echo.
echo ��ʼѹ��jpgͼƬ......
call %~dp0tools\jpegtran\jpegtran.bat
echo jpgͼƬѹ�����



::ѹ��png---------------------------------------------------------------------
echo.
echo.
echo ��ʼѹ��pngͼƬ......
call %~dp0tools\pngout\pngout.bat
echo pngͼƬѹ�����

::ѹ��gif---------------------------------------------------------------------
echo.
echo.
echo ��ʼѹ��gifͼƬ......
call %~dp0tools\gifsicle\gifsicle.bat
echo gifͼƬѹ�����


echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo �밴���������
:end
pause>nul

