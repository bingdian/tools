@echo off
color 03
set VersionText=(v0.1)
title -前端开发自动化优化平台-%VersionText%

echo 开始处理 %date% %time% -  %VersionText%.
echo 作者：永远的冰点
echo Email：imbingdian@gmail.com
echo 说明：该软件用于前端自动化优化，可以实现对css、js的语法检查和压缩，对图片的
echo 无损压缩。
echo.
echo.

echo **** 前端开发自动化优化平台 ****
::%~dp0
echo.
echo.
set closure_compiler_path=%~dp0tools\closure-compiler\compiler.jar
set yuicompressor_path=%~dp0tools\yuicompressor\yuicompressor-2.4.6.jar
set jpegtran_path=%~dp0tools\jpegtran\jpegtran.exe
set pngout_path=%~dp0tools\pngout\pngout.exe
set gifsicle_path=%~dp0tools\gifsicle\gifsicle.exe


::输入目录---------------------------------------------------------------------
echo 请输入要处理的项目文件夹目录（例如：d:\wwwroot\F2E,目录最后不用输入\）
echo 请确保项目文件夹下存以下目录：
echo -src 源码
echo -build 空文件夹
echo.
set /p project_path=请输入:
set src=\src
set build=\build
set src_path=%project_path%%src%
set build_path=%project_path%%build%
echo.
echo 您输入的目录是: %project_path%
echo 您要优化的目录是：%src_path%
echo 优化后的目录是：%build_path%
echo.
echo.
::确认提示
:choice
echo 是否确认优化该项目？
echo Y:确认
echo N:退出
set /p choice=请选择:
IF NOT "%choice%"=="" SET choice=%choice:~0,1%
if /i "%choice%"=="y" goto start
if /i "%choice%"=="n" goto end
echo 选择无效,请重新输入!
echo.
goto choice
@echo off

:start
echo.
echo.

::如果存在build目录，清空build目录
if exist %build_path% goto rd_build_path
:rd_build_path
rd /s /q %build_path%
md %build_path%
goto copy_to_build

::复制文件到build目录-----------------------------------------------------------
:copy_to_build
echo 开始优化处理......
xcopy /e /q /y %src_path% %build_path%
echo 优化文件目录生成完成


::对目录中的js用Google Closure Compiler进行验证---------------------------------
echo.
echo.
echo 开始压缩js......
call %~dp0tools\closure-compiler\auto-compiler.bat
echo js压缩完成


::压缩css-----------------------------------------------------------------------
echo.
echo.
echo 开始压缩css......
call %~dp0tools\yuicompressor\auto-yuicompressor.bat
echo css压缩完成

::压缩jpg---------------------------------------------------------------------
echo.
echo.
echo 开始压缩jpg图片......
call %~dp0tools\jpegtran\jpegtran.bat
echo jpg图片压缩完成



::压缩png---------------------------------------------------------------------
echo.
echo.
echo 开始压缩png图片......
call %~dp0tools\pngout\pngout.bat
echo png图片压缩完成

::压缩gif---------------------------------------------------------------------
echo.
echo.
echo 开始压缩gif图片......
call %~dp0tools\gifsicle\gifsicle.bat
echo gif图片压缩完成


echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo 请按任意键结束
:end
pause>nul

