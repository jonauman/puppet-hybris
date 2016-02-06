class apache::config {

  file { '/var/www/robots.txt':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0644,
    source  => 'puppet:///modules/apache/robots.txt',
  }

}
