class activemq::install {
  package { 'activemq': ensure  => installed }

  if $osfamily == 'RedHat' {
    package { 'mysql-connector-java': ensure  => installed }
  }
}
