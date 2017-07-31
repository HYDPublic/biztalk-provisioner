param(
  [Parameter(Mandatory=$true)]
  [ValidateSet("2016", "2013R2", "2013", "2010", "2009", "2006R2")]
  [String] $BTVersion,

  [Parameter(Mandatory=$true)]
  [ValidateSet("2016","2012R2","10","8.1")]
  [String] $winversion

  [Parameter(Mandatory=$true)]
  [ValidateSet("32","64")]
  [String] $bits

)

﻿<#
.SYNOPSIS
Download BizTalk Server prerequisite CAB-file (English)
.DESCRIPTION
This script downloads the prerequisite CAB-file for BizTalk Server. User is prompted for BizTalk and Windows version and bits
.EXAMPLE
./DownloadBizTalkCAB.ps1
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


# BizTalk Server 2016
if ($BTversion -eq "2016") {
    switch ($winversion) {
        "2016" { $source = "http://download.microsoft.com/download/4/2/E/42E95EB2-5B2A-495F-A407-323799CE3FD2/BtsRedistW2K12R2EN64.CAB" }
        "2012R2" { $source = "http://download.microsoft.com/download/D/2/F/D2F133EC-9DA3-40E7-89E2-C7B5EBDC176A/BtsRedistW2K12R2EN64.CAB" }
        "10" {
            switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/1/9/E/19E8B896-2755-4C14-A01C-90BC4A2A4692/BtsRedistW2K12R2EN64.cab" }
                32 { $source = "http://download.microsoft.com/download/5/5/4/554E1119-0E9D-46F5-8457-269575DAC657/BtsRedistWin81EN32.cab" }
            }
        }
        "8.1" {
            switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/A/4/F/A4FC6FD6-1F8D-4AF9-A148-A5205E605684/BtsRedistW2K12R2EN64.cab" }
                32 { $source = "http://download.microsoft.com/download/C/D/1/CD183203-AC5F-409D-9EF8-C265D1725B85/BtsRedistWin81EN32.cab" }
            }
        }
        default { Write-Host("`nInvalid or unsupported Windows version entered. Exiting") -fore Red
                    exit }
    }
}
# BizTalk Server 2013R2
elseif ($BTversion -eq "2013R2") {

    switch ($winversion) {
        "2012R2" { $source = "http://download.microsoft.com/download/4/D/A/4DA76382-88EC-46BD-85F1-785185004BE9/BtsRedistW2K12EN64.cab" }
        "2012" { $source = "http://download.microsoft.com/download/4/D/A/4DA76382-88EC-46BD-85F1-785185004BE9/BtsRedistW2K12EN64.cab" }
        "8.1" {
            switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/4/D/A/4DA76382-88EC-46BD-85F1-785185004BE9/BtsRedistWin8EN64.cab" }
                32 { $source = "http://download.microsoft.com/download/2/7/C/27CE697C-9869-42DB-A22A-95B76DE842AE/BtsRedistWin8EN32.cab" }
            }
        }
        "7" {
            switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/4/D/A/4DA76382-88EC-46BD-85F1-785185004BE9/BtsRedistWin7EN64.cab" }
                32 { $source = "http://download.microsoft.com/download/2/7/C/27CE697C-9869-42DB-A22A-95B76DE842AE/BtsRedistWin7EN32.cab" }
            }
        }
        default { Write-Host("`nInvalid or unsupported Windows version entered. Exiting") -fore Red
                    exit }
    }
}
# BizTalk Server 2013
elseif ($BTversion -eq "2013") {

    switch ($winversion) {
        "2012" { $source = "http://download.microsoft.com/download/2/7/C/27CE697C-9869-42DB-A22A-95B76DE842AE/BtsRedistW2K12EN64.cab" }
        "2008R2" { $source = "http://download.microsoft.com/download/2/7/C/27CE697C-9869-42DB-A22A-95B76DE842AE/BtsRedistW2K8R2EN64.cab" }
        "8" {
            switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/2/7/C/27CE697C-9869-42DB-A22A-95B76DE842AE/BtsRedistWin8EN64.cab" }
                32 { $source = "http://download.microsoft.com/download/2/7/C/27CE697C-9869-42DB-A22A-95B76DE842AE/BtsRedistWin8EN32.cab" }
            }
        }
        "7" { 
            switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/2/7/C/27CE697C-9869-42DB-A22A-95B76DE842AE/BtsRedistWin7EN64.cab" }
                32 { $source = "http://download.microsoft.com/download/2/7/C/27CE697C-9869-42DB-A22A-95B76DE842AE/BtsRedistWin7EN32.cab" }
            }
        }
        default { Write-Host("`nInvalid or unsupported Windows version entered. Exiting") -fore Red
                    exit }
    }
}
# BizTalk Server 2010
elseif ($BTversion -eq "2010") {
    switch ($winversion) {
        "2008R2" { $source = "http://download.microsoft.com/download/2/D/1/2D1B87F5-D9FF-40F4-BC56-B9B290C0E6B3/Bts2010Win2K8R2EN64.cab" }
        "2008" {
            switch ($bits) {
                64 { $source = "" }
                32 { $source = "http://download.microsoft.com/download/F/7/7/F773381D-3AE6-4B25-91C1-A3424E272ABD/Bts2010Win2K8EN32.cab" }
            }
        }
        "7" {
            switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/5/2/0/520FFC0E-04F6-4143-BD66-AC0D96291F4B/Bts2010Win7EN64.cab" }
                32 { $source = "http://download.microsoft.com/download/9/5/7/957242A4-63E1-4E91-81F1-ABDAC4FFD017/Bts2010Win7EN32.cab" }
            }
        }
        "Vista" {
            switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/E/E/2/EE2CB848-3669-4AAF-9941-22E370939496/Bts2010VistaEN64.cab" }
                32 { $source = "" }
            }
        }
        default { Write-Host("`nInvalid or unsupported Windows version entered. Exiting") -fore Red
                    exit }
    }
}
# BizTalk Server 2009
elseif ($BTversion -eq "2009") {
    switch ($winversion) {
        "2008" { switch ($bits) {
                64 { $source = "" }
                32 { $source = "http://download.microsoft.com/download/E/6/5/E65125DE-95B1-456E-A32E-54331C9D0CE0/BTSRedistW2K8EN32.cab" }
             }
        }
        "2003" { switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/6/C/1/6C1723C0-576E-454E-AA86-A5D2AF9A6A27/BTSRedistW2K3EN64.cab" }
                32 { $source = "" }
             }
        }
        "Vista" { switch ($bits) {
                64 { $source = "" }
                32 { $source = "" }
             }
        }
        "XP" { switch ($bits) {
                64 { $source = "" }
                32 { $source = "" }
              }
        }
        default { Write-Host("`nInvalid or unsupported Windows version entered. Exiting") -fore Red
                    exit }
    }
}
# BizTalk Server 2006R2
elseif ($BTversion -eq "2006R2") {
    switch ($winversion) {
        "2003" { switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/e/d/8/ed897961-7213-4816-be92-9178bea8e5c0/BtsRedistW2k3EN64.cab" }
                32 { $source = "http://download.microsoft.com/download/e/d/8/ed897961-7213-4816-be92-9178bea8e5c0/BtsRedistW2k3EN32.cab" }
             }
        }
        "Vista" { switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/e/d/8/ed897961-7213-4816-be92-9178bea8e5c0/BtsRedistVistaEN64.cab" }
                32 { $source = "http://download.microsoft.com/download/e/d/8/ed897961-7213-4816-be92-9178bea8e5c0/BtsRedistVistaEN32.cab" }
             }
        }
        "XP" { switch ($bits) {
                64 { $source = "http://download.microsoft.com/download/e/d/8/ed897961-7213-4816-be92-9178bea8e5c0/BtsRedistXpEN64.cab" }
                32 { $source = "http://download.microsoft.com/download/e/d/8/ed897961-7213-4816-be92-9178bea8e5c0/BtsRedistXpEN32.cab" }
              }
        }
        default { Write-Host("`nInvalid or unsupported Windows version entered. Exiting") -fore Red
                    exit }
    }
}
# Invalid Windows version
else {
    Write-Host("`nInvalid or unsupported Windows version entered. Exiting") -fore Red
    exit
}
Write-Host("`nDownloading BizTalk Server $BTversion prerequisite CAB for Windows $winversion - $bits bit edition...") -Fore Green

try {
    # Destination downloadfolder
    $destination = $env:USERPROFILE + "\Downloads\"
    $destination += getfilename $source

    # Download CAB-file
    Invoke-WebRequest $source -OutFile $destination

    Write-Host("`nFile download complete: " + $destination)
}
catch {
    Write-Host("`Download failed. Note that some URLs are not available, check the script source. If the URL is there, verify your Internet connection and try again.") -fore Red
    exit
}
