<#
.SYNOPSIS
Install SQL Server Management Tools
.DESCRIPTION
This script installs SQL Server Management Tools. User is prompted for setup.exe path. Configuration file should be in same folder as the script
.EXAMPLE
./SQLMgmtInstall.ps1
.NOTES
Run the script on the BizTalk server(s)
#>
cls
$Path = Read-Host("Please enter path where Setup.exe is located (e.g. E:)")
if (-not(Test-Path($Path))) {
    Write-Host("Invalid path")
    exit
}
$Path.TrimEnd("\"," ") | Out-Null

Write-Host("")
Write-Host("Installing SQL Server Management Tools...")  -Fore Green

Start-process $Path\setup.exe -ArgumentList "/ConfigurationFile=ConfigurationFile.ini"