::����o p q r s t

::����jpg�ļ����������С
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

::��ֹ��������ļ�
::for /r %build_path% %%r in (*.jpg) do echo "%%r"

echo ��Ŀ¼���ܹ���%TotalFiles%��jpg�ļ�,�ܴ�СΪ%TotalKB%KB

::��ʼѹ��
for /r %build_path% %%s in (*.jpg) do %jpegtran_path% -optimize -progressive -copy none "%%s" "%%s"


::ѹ�����С����
set TotalBytesOut=0
for /r %build_path% %%t in (*.jpg) do (
    set /a TotalBytesOut =TotalBytesOut+%%~zt
)
set /a saveing = (TotalBytes-TotalBytesOut)/1024
set /a TotalBytesOutKB = TotalBytesOut/1024
set /a ratio = (TotalBytesOut*100/TotalBytes)

echo ѹ���ɹ����ܹ�ѹ���� %TotalFiles% ���ļ�
echo ѹ�����ļ���С %TotalBytesOutKB% KB����ʡ�� %saveing% KB��ѹ����Ϊ %ratio%%%




