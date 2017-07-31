class biztalk {
  $downloadURL = "https://download.microsoft.com/download/7/1/E/71E5548E-CE2B-41F4-8015-79B8A8C8577D/BTS2013R2Evaluation_EN.exe"
  $stagingDir = 'C:/temp'

  download_file::download_file { "Download Installer" :
    url                   => $downloadURL,
    destination_directory => $stagingDir
  }

  # TODO cab needs to be downloaded first:
  # Download CAB: .\DownloadCAB.ps1 -BTVersion 2013R2 -winversion 2012R2 -bits 64
  # this downloads to Downloads dir.

  # this enables windows features for Biztalk
  # next: .\BizTalkWindowsFeatures.ps1
  # next: .\SQLWindowsFeatures.ps1

  $silentInstallCmd = "BTS2013R2Evaluation_EN.exe /quiet /norestart /addlocal all /cabpath C:\\Users\\Administrator\\Downloads\\"
  # TODO run above command

}
