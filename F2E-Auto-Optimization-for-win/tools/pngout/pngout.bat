::����u v w x y z

::����png�ļ����������С
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

::��ֹ��������ļ�
::for /r %build_path% %%x in (*.png) do echo "%%x"

echo ��Ŀ¼���ܹ���%pTotalFiles%��png�ļ�,�ܴ�СΪ%pTotalKB%KB

::��ʼѹ��
for /r %build_path% %%y in (*.png) do (
   %pngout_path% "%%y"
)

::ѹ�����С����
set pTotalBytesOut=0
for /r %build_path% %%z in (*.png) do (
    set /a pTotalBytesOut =pTotalBytesOut+%%~zz
)
set /a pSaveing = (pTotalBytes-pTotalBytesOut)/1024
set /a pTotalBytesOutKB = pTotalBytesOut/1024
set /a pRatio = (pTotalBytesOut*100/pTotalBytes)

echo ѹ���ɹ����ܹ�ѹ���� %pTotalFiles% ���ļ�
echo ѹ�����ļ���С %pTotalBytesOutKB% KB����ʡ�� %pSaveing% KB��ѹ����Ϊ %pRatio%%%




