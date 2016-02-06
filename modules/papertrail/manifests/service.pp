class papertrail::service {
  
  file { '/etc/init.d/papertrail':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0755,
    source  => 'puppet:///modules/papertrail/remote_syslog',
  }

  service { 'papertrail':
    ensure  => running,
    enable  => true,
    require => [ File['/etc/init.d/papertrail'], Package['remote_syslog'] ],
  }
}
