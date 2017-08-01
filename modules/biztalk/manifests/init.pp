class biztalk {
  $downloadURL = "https://download.microsoft.com/download/7/1/E/71E5548E-CE2B-41F4-8015-79B8A8C8577D/BTS2013R2Evaluation_EN.exe"
  $stagingDir = 'C:/tmp'
  $biztalkStagingDir = "$stagingDir/biztalk"
  $zipCommand = join(['"C:/Program Files/7-zip/7z.exe"', ' x BTS2013R2Evaluation_EN.exe -y ',' -o"',$biztalkStagingDir,'"'])
  $silentInstallCmd = "BTS2013R2Evaluation_EN.exe /quiet /norestart /addlocal all /cabpath C:\\Users\\Administrator\\Downloads\\"

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
   exec { "Download CAB" :
     command => file("biztalk/DownloadCAB.ps1"),
     cwd => $stagingDir,
     provider => powershell,
     logoutput => true,
     creates => "C:/Users/Administrator/Downloads/BtsRedistW2K12EN64.cab"
   }
  # } ~>
  # exec { "Download CAB" :
  #   command => "./DownloadCAB.ps1 -BTVersion $btVersion -winversion $winVersion -bits $bits",
  #   cwd => $stagingDir,
  #   provider => powershell,
  #   logoutput => true
  # }

  # TODO cab needs to be downloaded first:
  # Download CAB: .\DownloadCAB.ps1 -BTVersion 2013R2 -winversion 2012R2 -bits 64
  # this downloads to Downloads dir.

  # this enables windows features for Biztalk
  # next: .\BizTalkWindowsFeatures.ps1
  # next: .\SQLWindowsFeatures.ps1

  # TODO run above command

}
