<#
.SYNOPSIS
Install required Windows Features for BizTalk
.DESCRIPTION
This script installs required Windows Features for BizTalk
.EXAMPLE
./BizTalkWindowsFeatures.ps1
.NOTES
Run the script on the server that requires the features
#>
cls
Set-ExecutionPolicy RemoteSigned

# Vish: Windows installation media path changed to empty
# checked that this worked during manual install
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
Install-WindowsFeature -name Web-Default-Doc
Install-WindowsFeature -name Web-Dir-Browsing
Install-WindowsFeature -name Web-Http-Errors
Install-WindowsFeature -name Web-Static-Content
Install-WindowsFeature -name Web-Http-Logging
Install-WindowsFeature -name Web-Log-Libraries
Install-WindowsFeature -name Web-ODBC-Logging
Install-WindowsFeature -name Web-Request-Monitor
Install-WindowsFeature -name Web-Http-Tracing
Install-WindowsFeature -name Web-Stat-Compression
Install-WindowsFeature -name Web-Dyn-Compression
Install-WindowsFeature -name Web-Filtering
Install-WindowsFeature -name Web-Basic-Auth
Install-WindowsFeature -name Web-Digest-Auth
Install-WindowsFeature -name Web-Windows-Auth

Install-WindowsFeature -name Web-App-Dev -IncludeAllSubFeature
Install-WindowsFeature -name Web-Mgmt-Tools -IncludeAllSubFeature

Install-WindowsFeature -name NET-Framework-Core
Install-WindowsFeature -name NET-Framework-45-Core
Install-WindowsFeature -name NET-Framework-45-ASPNET
Install-WindowsFeature -name NET-WCF-HTTP-Activation45
Install-WindowsFeature -name NET-WCF-TCP-PortSharing45
Install-WindowsFeature -name RDC
Install-WindowsFeature -name RSAT-AD-PowerShell
Install-WindowsFeature -name RSAT-AD-AdminCenter
Install-WindowsFeature -name RSAT-ADDS-Tools
Install-WindowsFeature -name RSAT-ADLDS
Install-WindowsFeature -name FS-SMB1
Install-WindowsFeature -name PowerShell
Install-WindowsFeature -name PowerShell-V2
Install-WindowsFeature -name PowerShell-ISE
Install-WindowsFeature -name WAS-Process-Model
Install-WindowsFeature -name WAS-Config-APIs
Install-WindowsFeature -name WoW64-Support
