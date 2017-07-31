<#
.SYNOPSIS
Configure IIS Application Pools
.DESCRIPTION
This script configures IIS Application Pools for BizTalk
.EXAMPLE
./IIS-App-Pools.ps1
.NOTES
Run the script on the IIS server that requires the configuration
#>
cls
import-module webadministration

# Get SOAP account details
$SOAPusername = Read-Host("Please enter domain\username for SOAP app pool")
$SOAPpassword = Read-Host("Please enter password for SOAP app pool")

Write-Host("")
Write-Host("Creating BizTalkSOAPAppPool...")  -Fore Green

# Create SOAP app pool
$SOAPappPoolName = "BizTalkSOAPAppPool"
New-WebAppPool -Name $SOAPappPoolName -Force
$SOAPappPool = Get-Item "IIS:\AppPools\$SOAPappPoolName"
$SOAPappPool.processModel.identityType = 3
$SOAPappPool.processModel.username = $SOAPusername
$SOAPappPool.processModel.password = $SOAPpassword
$SOAPappPool.managedRuntimeVersion = "v4.0"
$SOAPappPool.managedPipeLineMode = "Integrated"
$SOAPappPool | Set-Item

# Get HTTP account details
Write-Host("")
$HTTPusername = Read-Host("Please enter domain\username for HTTP app pool")
$HTTPpassword = Read-Host("Please enter password for HTTP app pool")

Write-Host("")
Write-Host("Creating BizTalkHTTPAppPool...")  -Fore Green

# Create HTTP app pool
$HTTPappPoolName = "BizTalkHTTPAppPool"
New-WebAppPool -Name $HTTPappPoolName -Force
$HTTPappPool = Get-Item "IIS:\AppPools\$HTTPappPoolName"
$HTTPappPool.processModel.identityType = 3
$HTTPappPool.processModel.username = $HTTPusername
$HTTPappPool.processModel.password = $HTTPpassword
$HTTPappPool.managedRuntimeVersion = "v4.0"
$HTTPappPool.managedPipeLineMode = "Integrated"
$HTTPappPool | Set-Item