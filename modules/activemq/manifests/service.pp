class activemq::service {

  service { 'activemq':
    ensure  => running,
    enable  => true,
    require => Package['activemq'],
  }

}
