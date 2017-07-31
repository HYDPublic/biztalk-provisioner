<#
.SYNOPSIS
Disable IPv6 on a specified network
.DESCRIPTION
This script lists IPv6 networks, and the user can disable IPv6 on a specified network
.EXAMPLE
./DisableIPv6.ps1
.NOTES
Run the script on the server you want to check
#>
cls
Write-Host("Current IPv6 network connections") -fore Green
Get-NetAdapterBinding -ComponentID ms_tcpip6
$netAdapterName = Read-Host("`nWhich IPv6 network name do you want to disable?")
Disable-NetAdapterBinding -Name $netAdapterName -ComponentID ms_tcpip6