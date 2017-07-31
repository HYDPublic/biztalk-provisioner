<#
.SYNOPSIS
Stop and disable Print Spooler service
.DESCRIPTION
This script stops and disabled the Print Spooler service
.EXAMPLE
./StopPrintSpooler.ps1
.NOTES
Run the script on the server that requires the configuration
#>
cls
Get-Service Spooler | Stop-Service -PassThru | Set-Service -StartupType disabled
Write-Host "Print Spooler has been stopped and disabled"