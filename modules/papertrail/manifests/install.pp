class papertrail::install {

  $rubydev = $osfamily ? {
    'Debian'  => 'ruby1.9.1-dev',
    'RedHat'  => 'ruby-devel',
    default   => 'ruby1.9.1-dev',
  }

  package { 'remote_syslog':
    ensure    => present,
    provider  => gem,
    require   => Package["$rubydev"],
  }
}
