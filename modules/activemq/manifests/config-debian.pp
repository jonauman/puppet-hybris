class activemq::config ( $hash ) {

  notice("env ins $env")

  file { '/etc/activemq/instances-available/main/activemq.xml':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template('activemq/activemq-mysql.xml.erb'),
    require => Package['activemq'],
  }

  file { '/etc/activemq/instances-enabled/main':
    ensure  => link,
    target  => '/etc/activemq/instances-available/main',
  } 

}
