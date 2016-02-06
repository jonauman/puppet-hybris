class web::hosts {

  file { '/etc/hosts':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template("web/hosts.${env}.erb"),
  }

}
