
$plink = 'C:\Program Files\PuTTY\plink.exe'
$pscp = 'C:\Program Files\PuTTY\pscp.exe'
$ipvar = "192.168.238.129"
$usernamevar = "localadm"
$vmipun = $usernamevar + '@' + $ipvar
$vmipuntmp = $vmipun + ':/tmp'
$sshlogvar = "C:\Users\tom\Desktop\repo\CI\LinuxInstall\sshlog" + $ipvar + ".txt"
$passwordvar = Read-Host -Prompt "Enter password" -AsSecureString
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $usernamevar, $passwordvar
$passwordvardc = $Credential.GetNetworkCredential().password

Start-Process -FilePath $pscp -ArgumentList " -v -pw $passwordvardc prepare-ubuntu-18-template.sh $vmipuntmp" -Verbose -Wait
Start-Process -FilePath $plink -ArgumentList " -ssh -pw $passwordvardc -t $vmipun -sshlog $sshlogvar -v -batch (sudo apt-get install dos2unix -y;dos2unix /tmp/prepare-ubuntu-18-template.sh;chmod +x /tmp/prepare-ubuntu-18-template.sh;sudo -S /tmp/prepare-ubuntu-18-template.sh)" -Verbose -Wait

#$pscp -pw $passwordvar prepare-ubuntu-18-template.sh %usernamevar%@%ipvar%:/tmp
#&$plink -ssh -pw %passwordvar% -t %usernamevar%@%ipvar% -sshlog sshlog%ipvar%.txt -v -batch (sudo apt-get install dos2unix -y;dos2unix /tmp/prepare-ubuntu-18-template.sh;chmod +x /tmp/prepare-ubuntu-18-template.sh;sudo -S /tmp/prepare-ubuntu-18-template.sh)

#&$plink -l $username -pw $pw -m $commands -ssh $switch