::设置u v w x y z

::计算png文件个数及其大小
::for %%u in (%build_path%\*.png) do (echo;%%~zu)

set pTotalFiles=0
for /r %build_path% %%v in (*.png) do (
    set /a pTotalFiles+=1  
)

set pTotalBytes=0
for /r %build_path% %%w in (*.png) do (
    set /a pTotalBytes =pTotalBytes+%%~zw
)
set /a pTotalKB = pTotalBytes/1024

::禁止输出所有文件
::for /r %build_path% %%x in (*.png) do echo "%%x"

echo 该目录下总共有%pTotalFiles%个png文件,总大小为%pTotalKB%KB

::开始压缩
for /r %build_path% %%y in (*.png) do (
   %pngout_path% "%%y"
)

::压缩后大小计算
set pTotalBytesOut=0
for /r %build_path% %%z in (*.png) do (
    set /a pTotalBytesOut =pTotalBytesOut+%%~zz
)
set /a pSaveing = (pTotalBytes-pTotalBytesOut)/1024
set /a pTotalBytesOutKB = pTotalBytesOut/1024
set /a pRatio = (pTotalBytesOut*100/pTotalBytes)

echo 压缩成功，总共压缩了 %pTotalFiles% 个文件
echo 压缩后文件大小 %pTotalBytesOutKB% KB，节省了 %pSaveing% KB，压缩率为 %pRatio%%%




