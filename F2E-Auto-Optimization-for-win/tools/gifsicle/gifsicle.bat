::设置o p q r s t

::计算gif文件个数及其大小
::for %%o in (%build_path%\*.gif) do (echo;%%~zo)

set TotalFiles=0
for /r %build_path% %%p in (*.gif) do (
    set /a TotalFiles+=1  
)

set TotalBytes=0
for /r %build_path% %%q in (*.gif) do (
    set /a TotalBytes =TotalBytes+%%~zq
)
set /a TotalKB = TotalBytes/1024

echo 该目录下总共有%TotalFiles%个gif文件,总大小为%TotalKB%KB

::开始压缩
for /r %build_path% %%y in (*.gif) do (
   %gifsicle_path% -b -O3 "%%y"
)

::压缩后大小计算
set TotalBytesOut=0
for /r %build_path% %%t in (*.gif) do (
    set /a TotalBytesOut =TotalBytesOut+%%~zt
)
set /a saveing = (TotalBytes-TotalBytesOut)/1024
set /a TotalBytesOutKB = TotalBytesOut/1024
set /a ratio = (TotalBytesOut*100/TotalBytes)

echo 压缩成功，总共压缩了 %TotalFiles% 个文件
echo 压缩后文件大小 %TotalBytesOutKB% KB，节省了 %saveing% KB，压缩率为 %ratio%%%




