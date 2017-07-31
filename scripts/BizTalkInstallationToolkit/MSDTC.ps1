<#
.SYNOPSIS
Configure local MSDTC for BizTalk
.DESCRIPTION
This script configures MSDTC for BizTalk. Requires Windows 8.1/Server 2012 R2 and PowerShell 4.0 or newer
.EXAMPLE
./MSDTC.ps1
.NOTES
Run the script on the servers that requires the configuration (BizTalk and SQL)
#>
cls
# Enable MSDTC for Network Access
Write-Host "Enabling MSDTC for Network Access..." –fore green

try {
    Set-DtcNetworkSetting –DtcName Local –AuthenticationLevel Mutual –InboundTransactionsEnabled 1 –OutboundTransactionsEnabled 1 –RemoteClientAccessEnabled 1 –confirm:$false

    Restart-Service MSDTC

    Write-Host "`nMSDTC has been configured and restarted"
}
catch {
    Write-Host "MSDTC setup failed" -fore red
}