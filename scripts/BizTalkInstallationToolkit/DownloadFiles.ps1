<#
.SYNOPSIS
Download BizTalk tools
.DESCRIPTION
This script downloads various BizTalk tools from the Internet
.EXAMPLE
./DownloadFiles.ps1
.NOTES
File will be downloaded in current user's Download folder
#>
cls

# Get filename from URL
function getfilename($source) {
    $pieces=$source.split("/") 
    $piecescount=$pieces.Count 
    $filename=$pieces[$piecescount-1] 
    return $filename
}

$url = @()
$localList = @()
$fileList = @()

# Array of URLs to tools
$url += "http://download.microsoft.com/download/d/0/0/d00c8f6b-135d-4441-a97b-9de16a1935c1/DTCPing.exe"
$url += "https://gallery.technet.microsoft.com/Registry-Settings-to-207c97e4/file/107914/1/MakeBizTalkOptimized.zip"
$url += "https://gallery.technet.microsoft.com/Add-MSDTC-Port-range-to-c0a31d12/file/115472/1/DTCPorts.reg"
$url += "http://download.microsoft.com/download/8/E/1/8E16A4C7-DD28-4368-A83A-282C82FC212A/MBSASetup-x64-EN.msi"
$url += "https://download.microsoft.com/download/7/0/2/702CBC49-3162-4665-BDF8-CCEE51A972D3/BPA.zip"
$url += "https://download.microsoft.com/download/6/D/3/6D38D0F5-9674-484D-B193-223CAF7EF984/BHMv4.0.zip"
$url += "https://gallery.technet.microsoft.com/Pre-allocate-space-and-2f30403e/file/66311/1/SQLQuery2SetSpaceAndAutogrowthSettings.sql"

# Get all filenames
for($a=0;$a -lt $url.Count;$a++)
{
    $fileList += getfilename $url[$a]
}

# Download all files
for($b=0;$b -lt $url.Count;$b++)
{
    $localList += $env:USERPROFILE + "\Downloads\" + $fileList[$b]
    Invoke-Command -scriptblock { Invoke-WebRequest $url[$b] -OutFile $localList[$b] }
}