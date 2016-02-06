class activemq::config ( $hash ) {

  # RedHat config 

  file { '/etc/activemq/activemq.xml':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template('activemq/activemq-mysql.xml.erb'),
    require => Package['activemq'],
  }

  file {'/usr/share/activemq/lib/optional/mysql-connector-java.jar':
    ensure  => link,
    target  => '/usr/share/java/mysql-connector-java.jar',
  }
}
