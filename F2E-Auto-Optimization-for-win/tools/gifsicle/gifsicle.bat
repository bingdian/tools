::����o p q r s t

::����gif�ļ����������С
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

echo ��Ŀ¼���ܹ���%TotalFiles%��gif�ļ�,�ܴ�СΪ%TotalKB%KB

::��ʼѹ��
for /r %build_path% %%y in (*.gif) do (
   %gifsicle_path% -b -O3 "%%y"
)

::ѹ�����С����
set TotalBytesOut=0
for /r %build_path% %%t in (*.gif) do (
    set /a TotalBytesOut =TotalBytesOut+%%~zt
)
set /a saveing = (TotalBytes-TotalBytesOut)/1024
set /a TotalBytesOutKB = TotalBytesOut/1024
set /a ratio = (TotalBytesOut*100/TotalBytes)

echo ѹ���ɹ����ܹ�ѹ���� %TotalFiles% ���ļ�
echo ѹ�����ļ���С %TotalBytesOutKB% KB����ʡ�� %saveing% KB��ѹ����Ϊ %ratio%%%




