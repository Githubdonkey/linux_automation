$plink = 'C:\Program Files\PuTTY\plink.exe'
$pscp = 'C:\Program Files\PuTTY\pscp.exe'
$ipvars = @("54.162.121.65","3.86.46.239")
$usernamevar = "ubuntu"
$ppkKey = $PSScriptRoot + "\ubuntuTestingPrivate.ppk"

$sysprepU18 = '(sudo apt-get install dos2unix -y;dos2unix /tmp/prepare-ubuntu-18-template.sh;chmod +x /tmp/prepare-ubuntu-18-template.sh;sudo -S /tmp/prepare-ubuntu-18-template.sh)'
$update1U18 = '(sudo apt-get update -y;sudo apt-get install dos2unix -y)'

foreach ($ipvar in $ipvars) {
   $vmipun = $usernamevar + '@' + $ipvar
   $vmipuntmp = $vmipun + ':/tmp'
   $sshlogvar = $PSScriptRoot + "\sshlog" + $ipvar + ".txt"
   
   $process = Start-Process -FilePath $pscp -ArgumentList " -v -i $ppkKey prepare-ubuntu-18-template.sh $vmipuntmp" -Verbose -PassThru -Wait
   if(($process.ExitCode -eq 0)) {Write-Host "$ipvar Copy Successfull exit 0"} else {Write-Host "$ipvar Copy Failed exit $process.ExitCode";exit 1}
   
   $process = Start-Process -FilePath $plink -ArgumentList " -ssh -v -i $ppkKey -t $vmipun -sshlog $sshlogvar -batch $update1U18" -Verbose -PassThru -Wait
   if(($process.ExitCode -eq 0)) {Write-Host "$ipvar Install Successfull exit 0"} else {Write-Host "$ipvar Copy Failed exit $process.ExitCode";exit 1}
 }