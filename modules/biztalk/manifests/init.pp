class biztalk {
  $downloadURL = "https://download.microsoft.com/download/7/1/E/71E5548E-CE2B-41F4-8015-79B8A8C8577D/BTS2013R2Evaluation_EN.exe"
  $stagingDir = 'C:/tmp'
  $biztalkStagingDir = "$stagingDir/biztalk"
  $biztalkCabPath = "C:/Users/Administrator/Downloads/BtsRedistW2K12EN64.cab"
  $zipCommand = join(['"C:/Program Files/7-zip/7z.exe"', ' x BTS2013R2Evaluation_EN.exe -y ',' -o"',$biztalkStagingDir,'"'])
  $silentInstallCmd = "Setup.exe /quiet /passive /norestart /addlocal all /cabpath $biztalkCabPath"

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
   }

  # TODO run above command

}
