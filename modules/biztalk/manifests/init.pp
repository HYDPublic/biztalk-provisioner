# references:
# ADDLOCAL options: https://social.technet.microsoft.com/wiki/contents/articles/571.listing-of-values-for-the-addlocal-command-when-performing-a-silent-installation-of-biztalk-server-2010.aspx
# Silent Install Options: https://msdn.microsoft.com/en-in/library/jj248690.aspx
# install and configure biztalk: https://blog.sandro-pereira.com/2015/01/13/biztalk-server-2013-r2-installation-and-configuration-install-and-configure-biztalk-server-2013-r2-part-9/
class biztalk {
  $downloadURL = "https://download.microsoft.com/download/7/1/E/71E5548E-CE2B-41F4-8015-79B8A8C8577D/BTS2013R2Evaluation_EN.exe"
  $stagingDir = 'C:/tmp'
  $biztalkStagingDir = "$stagingDir/biztalk"
  $biztalkCabPath = "C:/Users/Administrator/Downloads/BtsRedistW2K12EN64.cab"
  $zipCommand = join(['"C:/Program Files/7-zip/7z.exe"', ' x BTS2013R2Evaluation_EN.exe -y ',' -o"',$biztalkStagingDir,'"'])
  $biztalkInstallLog = "C:/biztalk.log"
  $biztalkAddLocalOptions = join(["BizTalk,WMI,InfoWorkerApps",
    "BAMPortal,Documentation",
    "Runtime,Engine,MOT,MSMQ",
    "MsEDIAS2,MsEDIAS2StatusReporting",
    "WCFAdapter",
    "AdminAndMonitoring,AdminTools,MonitoringAndTracking,BizTalkAdminSnapIn,BAMTools,PAM",
    "WcfAdapterAdminTools",
    "SSOAdmin,SSOServer,RulesEngine,OLAPNS,FBAMCLIENT,BAMEVENTAPI,ProjectBuildComponent"
    ],",")

# This is the install command that works!
# .\Setup.exe /L C:/biztalk.log /passive /norestart /addlocal `
# "BizTalk,WMI,InfoWorkerApps,BAMPortal,Documentation,Runtime,Engine,MOT,MSMQ,MsEDIAS2,MsEDIAS2StatusReporting,WCFAdapter,AdminAndMonitoring,AdminTools,MonitoringAndTracking,BizTalkAdminSnapIn,BAMTools,PAM,WcfAdapterAdminTools,SSOAdmin,SSOServer,RulesEngine,OLAPNS,FBAMCLIENT,BAMEVENTAPI,ProjectBuildComponent" `
#  /cabpath "C:/Users/Administrator/Downloads/BtsRedistW2K12EN64.cab"

  $biztalkSilentInstallCmd = ".\\Setup.exe /L $biztalkInstallLog /passive /norestart /addlocal \"$biztalkAddLocalOptions\" /cabpath $biztalkCabPath"

  file { $stagingDir:
    ensure => 'directory',
  } ~>
  file { $biztalkStagingDir:
    ensure => 'directory',
  } ~>
  download_file { "Download Installer to Staging Dir" :
    url                   => $downloadURL,
    destination_directory => $stagingDir
  } ~>
   exec { "Extract Installer to Staging Dir" :
     command => $zipCommand,
     cwd => $stagingDir,
     logoutput => true,
     creates => "$biztalkStagingDir/BT Server/Setup.exe"
   } ~>
   exec { "Download Prerequisite CAB" :
     command => file("biztalk/DownloadCAB.ps1"),
     cwd => $stagingDir,
     provider => powershell,
     logoutput => true,
     creates => $biztalkCabPath
   } ~>
   exec { "Enable Biztalk Prerequisite Windows Features" :
     command => file("biztalk/BizTalkWindowsFeatures.ps1"),
     cwd => $stagingDir,
     provider => powershell,
     logoutput => true
   } ~>
   exec { "Enable SQL Prerequisite Windows Features" :
     command => file("biztalk/SQLWindowsFeatures.ps1"),
     cwd => $stagingDir,
     provider => powershell,
     logoutput => true
   } ~>
   exec { "Install Biztalk Server from commandline" :
     command => $biztalkSilentInstallCmd,
     cwd => "$biztalkStagingDir/BT Server/",
     provider => powershell,
     logoutput => true
   }
  # TODO run above command

}
