param(
  [Parameter(Mandatory=$true)]
  [String] $localPath,
  [Parameter(Mandatory=$true)]
  [String] $remotePath,
  [Parameter(Mandatory=$true)]
  [String] $username,
  [Parameter(Mandatory=$true)]
  [String] $password
)

$ErrorActionPreference = "stop"

$port = 5985
$awsInstanceName = "biztalk-server"
Write-Host "-- Getting Instance IP..."


$ip = "& `"C:\HashiCorp\Vagrant\bin\vagrant.exe`" awsinfo -m $awsInstanceName -k host"
$ip = "ec2-13-126-116-43.ap-south-1.compute.amazonaws.com"
Write-Host "-- Creating Session to $ip..."
Enable-PSRemoting -force
winrm set winrm/config/client "@{TrustedHosts=`"$ip`"}"
$passwordSecure = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($username,$passwordSecure)
$session = New-PSSession -ComputerName $ip -Port $port -Credential $cred -Authentication Basic
Write-Host "-- COPY --"
Write-Host "-- FROM $localPath"
Write-Host "-- TO $ip"
Write-Host "-- DIR: $remotePath"
Copy-Item -ToSession $session -Path $localPath -Destination $remotePath -Recurse
