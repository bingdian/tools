::设置o p q r s t

::计算jpg文件个数及其大小
::for %%o in (%build_path%\*.jpg) do (echo;%%~zo)

set TotalFiles=0
for /r %build_path% %%p in (*.jpg) do (
    set /a TotalFiles+=1  
)

set TotalBytes=0
for /r %build_path% %%q in (*.jpg) do (
    set /a TotalBytes =TotalBytes+%%~zq
)
set /a TotalKB = TotalBytes/1024

::禁止输出所有文件
::for /r %build_path% %%r in (*.jpg) do echo "%%r"

echo 该目录下总共有%TotalFiles%个jpg文件,总大小为%TotalKB%KB

::开始压缩
for /r %build_path% %%s in (*.jpg) do %jpegtran_path% -optimize -progressive -copy none "%%s" "%%s"


::压缩后大小计算
set TotalBytesOut=0
for /r %build_path% %%t in (*.jpg) do (
    set /a TotalBytesOut =TotalBytesOut+%%~zt
)
set /a saveing = (TotalBytes-TotalBytesOut)/1024
set /a TotalBytesOutKB = TotalBytesOut/1024
set /a ratio = (TotalBytesOut*100/TotalBytes)

echo 压缩成功，总共压缩了 %TotalFiles% 个文件
echo 压缩后文件大小 %TotalBytesOutKB% KB，节省了 %saveing% KB，压缩率为 %ratio%%%




