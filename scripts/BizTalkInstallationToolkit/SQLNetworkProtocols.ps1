<#
.SYNOPSIS
Configure SQL Configuration Manager settings for BizTalk
.DESCRIPTION
This script configures TCP/IP, Named Pipes and Shared Memory for BizTalk use
.EXAMPLE
./SQLNetworkProtocols.ps1
.NOTES
Run the script on the SQL server that requires the configuration
#>
cls
import-module "sqlps"
$smo = 'Microsoft.SqlServer.Management.Smo.'
$wmi = new-object ($smo + 'Wmi.ManagedComputer').

# Get instance
$InstanceName = [System.String]$Args[0]
if (!$InstanceName) {
    $InstanceName = Read-Host("Please enter SQL instance name (default is MSSQLSERVER)")
}

Write-Host("")
Write-Host("Enabling TCP/IP...")  -Fore Green

# Enable TCP/IP on the instance
$uri = "ManagedComputer[@Name='" + (get-item env:\computername).Value + "']/ServerInstance[@Name='$InstanceName']/ServerProtocol[@Name='Tcp']"
$Tcp = $wmi.GetSmoObject($uri)
$Tcp.IsEnabled = $true
$Tcp.Alter()

Write-Host("")
Write-Host("Enabling Named Pipes...")  -Fore Green

# Enable Named Pipes on the instance
$uri = "ManagedComputer[@Name='" + (get-item env:\computername).Value + "']/ServerInstance[@Name='$InstanceName']/ServerProtocol[@Name='Np']"
$Np = $wmi.GetSmoObject($uri)
$Np.IsEnabled = $true
$Np.Alter()

Write-Host("")
Write-Host("Disabling Shared Memory....")  -Fore Green

# Disable Shared memory on the instance
$uri = "ManagedComputer[@Name='" + (get-item env:\computername).Value + "']/ServerInstance[@Name='$InstanceName']/ServerProtocol[@Name='Sm']"
$Sm = $wmi.GetSmoObject($uri)
$Sm.IsEnabled = $false
$Sm.Alter()

Write-Host("")
Write-Host("Restarting SQL Server service...")  -Fore Green

# Restart SQL Server service
$service = get-service "$InstanceName"  
restart-service $service.name -force 

C: