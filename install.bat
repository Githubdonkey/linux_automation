@echo off
:MENU
CLS
ECHO ***************************************************************************
ECHO *                            --Trailer #:
ECHO *                             VCT Current
ECHO *                             UGT Current
ECHO * 
ECHO ***************************************************************************
ECHO *  
ECHO *   (1)-sysprep Ubuntu 18.04 IP  username  password
ECHO *   (2)-sysprep Ubuntu 18.04 IP  ssh key
ECHO ***************************************************************************
ECHO * (d)-download release from ISD
ECHO ***************************************************************************
SET /P M=Type like a gangsta 1-3, M1-M3, R1-R3, D1-D3 then press ENTER:

IF %M%==1 GOTO 1
IF %M%==2 GOTO 2
IF %M%==exit GOTO exit
ECHO CHOICE NOT FOUND
PAUSE
GOTO MENU

::***************************************************************Load Latest**********************************************************************************************************

:DOWNLOAD
echo Logging in to server........

echo Downloading Installers..
::DEL /F /Q C:\local_build_server\Build\_VCT\*.*
::DEL /F /Q C:\local_build_server\Build\_UGT\*.*
::echo Downloading VCOT Installer.......
::copy "\\styx\BuildServerStyx\Projects\Maneuver Nightly\Installer\Combat Patrol Setup.exe" C:\local_build_server\Build\_VCT\vct_%today%.exe
::echo VCOT Installer Copied from server.......
GOTO MENU

::***************************************************************Load Latest**********************************************************************************************************

:1
::SET /P ipvar=Type IP of VM then press ENTER:
::SET /P usernamevar=Type username then press ENTER:
set ipvar=192.168.238.129
set usernamevar=localadm
set passwordvar="$RFV&UJM2wsx"

pscp -pw %passwordvar% prepare-ubuntu-18-template.sh %usernamevar%@%ipvar%:/tmp
plink -ssh -pw %passwordvar% -t %usernamevar%@%ipvar% -sshlog sshlog%ipvar%.txt -v -batch (sudo apt-get install dos2unix -y;dos2unix /tmp/prepare-ubuntu-18-template.sh;chmod +x /tmp/prepare-ubuntu-18-template.sh;sudo -S /tmp/prepare-ubuntu-18-template.sh)
GOTO MENU

:2
SET /P ipvar=Type IP of VM then press ENTER:
SET /P usernamevar=Type username then press ENTER:

pscp -i "C:\Users\tom\Desktop\repo\CI\ubuntuTestingPrivate.ppk" prepare-ubuntu-18-template.sh %usernamevar%@%ipvar%:/tmp
plink -ssh -i "C:\Users\tom\Desktop\repo\CI\ubuntuTestingPrivate.ppk" -sshlog sshlog%ipvar%.txt -t %usernamevar%@%ipvar% -v -batch (sudo apt-get install dos2unix -y;dos2unix /tmp/prepare-ubuntu-18-template.sh;chmod +x /tmp/prepare-ubuntu-18-template.sh;sudo -S /tmp/prepare-ubuntu-18-template.sh)
pause
GOTO MENU

:exit
exit 0

















::set ipvar=192.168.238.129

::plink localadm@192.168.238.128 crontab -l
::plink localadm@192.168.238.128 (hostname;crontab -l)
::plink localadm@192.168.238.128 -sshlog sshlog.txt -m commands.txt
::plink localadm@192.168.238.128 -m commands.txt
::echo "%~1"

::IpUserNamePassword
::pscp -pw "%~1" prepare-ubuntu-18-template.sh localadm@%ipvar%:/tmp
::plink -ssh -pw "%~1" -t localadm@%ipvar% -v -batch (sudo apt-get install dos2unix -y;dos2unix /tmp/prepare-ubuntu-18-template.sh;chmod +x /tmp/prepare-ubuntu-18-template.sh;sudo -S /tmp/prepare-ubuntu-18-template.sh)

::plink -ssh -pw "%~1" -t localadm@%ipvar% -v "sudo apt-get install dos2unix -y"

::plink -ssh -pw "%~1" -t localadm@%ipvar% -v -batch "dos2unix /tmp/prepare-ubuntu-18-template.sh"
::plink -ssh -pw "%~1" -t localadm@%ipvar% -v -batch "sudo /tmp/prepare-ubuntu-18-template.sh"

::pscp -pw "%~1" prepare-ubuntu-18-template.sh localadm@192.168.238.128:/tmp
::plink localadm@192.168.238.128 -v -batch -ssh -m commands.txt -pw "%~1"
::plink localadm@192.168.238.128 -pw "%~1" -v -batch (chmod +x /tmp/prepare-ubuntu-18-template.sh)
::plink -ssh -pw "%~1" -t localadm@192.168.238.128 -v "sudo apt-get install dos2unix -y"
::plink localadm@192.168.238.128 -pw "%~1" -v -batch (sudo -S /tmp/prepare-ubuntu-18-template.sh)
::plink.exe -ssh -pw "%~1" -t localadm@192.168.238.128 "/tmp/prepare-ubuntu-18-template.sh"
::pause