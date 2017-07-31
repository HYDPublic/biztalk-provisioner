<#
.SYNOPSIS
Install required Windows Features for SQL
.DESCRIPTION
This script installs required Windows Features for SQL
.EXAMPLE
./SQLWindowsFeatures.ps1
.NOTES
Run the script on the server that requires the features
#>
cls
Set-ExecutionPolicy RemoteSigned

# Vish: Set Windows installation media path to empty
$AlternateSourcePath = ""

# Create the Servicing Registry Key and LocalSourcePath String Value
New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Servicing -Force
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Servicing -Name "LocalSourcePath" -Value $AlternateSourcePath -Force

Write-Host("")
Write-Host("Installing Windows Features...") -Fore Green

# Install required Windows Features
Import-Module ServerManager
Install-WindowsFeature -name FS-FileServer
Install-WindowsFeature -name Storage-Services
Install-WindowsFeature -name NET-Framework-Core
Install-WindowsFeature -name NET-Framework-45-Core
Install-WindowsFeature -name NET-WCF-HTTP-Activation45
Install-WindowsFeature -name NET-WCF-TCP-PortSharing45
Install-WindowsFeature -name RDC
Install-WindowsFeature -name RSAT-SNMP
Install-WindowsFeature -name FS-SMB1
Install-WindowsFeature -name SNMP-WMI-Provider
Install-WindowsFeature -name Telnet-Client
Install-WindowsFeature -name PowerShell
Install-WindowsFeature -name PowerShell-V2
Install-WindowsFeature -name PowerShell-ISE
Install-WindowsFeature -name WoW64-Support
