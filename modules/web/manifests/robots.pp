class web::robots {

  file { '/var/www/robots.txt':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0644,
    source  => 'puppet:///modules/web/robots.txt',
  }

}
