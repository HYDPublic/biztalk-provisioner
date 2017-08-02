# http://windowsitpro.com/sql-server/perform-silent-install-sql-server
class sqlserver {
  $sqlServerDownloadLink = "http://download.microsoft.com/download/B/F/2/BF2EDBB8-004D-47F3-AA2B-FEA897591599/SQLServer2016-SSEI-Expr.exe"
  $stagingDir = 'C:/tmp'
  download_file { "Download SQL Installer to Staging Dir" :
    url                   => $sqlServerDownloadLink,
    destination_directory => $stagingDir
  }

}
