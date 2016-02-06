class sudoers {
  include sudoers::install
  include sudoers::config
  include sudoers::hiera

  file { "/etc/sudoers.d":
    ensure  => directory,
    mode    => 0440,
    owner   => root,
    group   => root,
  }

  define sudoers($command = 'ALL') {
    $filename = regsubst($title, '\.', '_')

    file { "/etc/sudoers.d/${filename}":
      owner   => root,
      group   => root,
      mode    => 0440,
      content => template('sudoers/sudoers.d.erb'),
      require => File["/etc/sudoers.d"],
    }
  }
}
