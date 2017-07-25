#####
# WINDOWS SERVER BOOTSTRAP SCRIPT FOR puppet
#
# bootstrap script mostly inspired by the following links:
# https://stackoverflow.com/a/9949909/682912
# https://gist.githubusercontent.com/masterzen/6714787/raw
####


Start-Transcript -Path 'c:\bootstrap-transcript.txt' -Force
# strict mode for syntax
Set-StrictMode -Version Latest
# Unrestricted execution
Set-ExecutionPolicy Unrestricted
# fail on error
$ErrorActionPreference = "Stop"

$log = 'c:\Bootstrap.txt'

$systemPath = [Environment]::GetFolderPath([Environment+SpecialFolder]::System)
$sysNative = [IO.Path]::Combine($env:windir, "sysnative")
#http://blogs.msdn.com/b/david.wang/archive/2006/03/26/howto-detect-process-bitness.aspx
$Is32Bit = (($Env:PROCESSOR_ARCHITECTURE -eq 'x86') -and ($Env:PROCESSOR_ARCHITEW6432 -eq $null))
Add-Content $log -value "Is 32-bit [$Is32Bit]"

#http://msdn.microsoft.com/en-us/library/ms724358.aspx
$coreEditions = @(0x0c,0x27,0x0e,0x29,0x2a,0x0d,0x28,0x1d)
$IsCore = $coreEditions -contains (Get-WmiObject -Query "Select OperatingSystemSKU from Win32_OperatingSystem" | Select -ExpandProperty OperatingSystemSKU)
Add-Content $log -value "Is Core [$IsCore]"


# move to home, PS is incredibly complex :)
cd $Env:USERPROFILE
Set-Location -Path $Env:USERPROFILE
[Environment]::CurrentDirectory=(Get-Location -PSProvider FileSystem).ProviderPath



#.net 4
if ((Test-Path "${Env:windir}\Microsoft.NET\Framework\v4.0.30319") -eq $false)
{
    $netUrl = if ($IsCore) {'http://download.microsoft.com/download/3/6/1/361DAE4E-E5B9-4824-B47F-6421A6C59227/dotNetFx40_Full_x86_x64_SC.exe' } `
    else { 'http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe' }

    $client.DownloadFile( $netUrl, 'dotNetFx40_Full.exe')
    Start-Process -FilePath 'C:\Users\Administrator\dotNetFx40_Full.exe' -ArgumentList '/norestart /q  /ChainingPackage ADMINDEPLOYMENT' -Wait -NoNewWindow
    del dotNetFx40_Full.exe
    Add-Content $log -value "Found that .NET4 was not installed and downloaded / installed"
}

#configure powershell to use .net 4
$config = @'
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <!-- http://msdn.microsoft.com/en-us/library/w4atty68.aspx -->
  <startup useLegacyV2RuntimeActivationPolicy="true">
    <supportedRuntime version="v4.0" />
    <supportedRuntime version="v2.0.50727" />
  </startup>
</configuration>
'@

if (Test-Path "${Env:windir}\SysWOW64\WindowsPowerShell\v1.0\powershell.exe")
{
    $config | Set-Content "${Env:windir}\SysWOW64\WindowsPowerShell\v1.0\powershell.exe.config"
    Add-Content $log -value "Configured 32-bit Powershell on x64 OS to use .NET 4"
}
if (Test-Path "${Env:windir}\system32\WindowsPowerShell\v1.0\powershell.exe")
{
    $config | Set-Content "${Env:windir}\system32\WindowsPowerShell\v1.0\powershell.exe.config"
    Add-Content $log -value "Configured host OS specific Powershell at ${Env:windir}\system32\ to use .NET 4"
}

#enable powershell servermanager cmdlets (only for 2008 r2 + above)
if ($IsCore)
{
    DISM /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShell /FeatureName:ServerManager-PSH-Cmdlets /FeatureName:BestPractices-PSH-Cmdlets
    Add-Content $log -value "Enabled ServerManager and BestPractices Cmdlets"

    #enable .NET flavors - on server core only -- errors on regular 2008
    DISM /Online /Enable-Feature /FeatureName:NetFx2-ServerCore /FeatureName:NetFx2-ServerCore-WOW64 /FeatureName:NetFx3-ServerCore /FeatureName:NetFx3-ServerCore-WOW64
    Add-Content $log -value "Enabled .NET frameworks 2 and 3 for x86 and x64"
}
