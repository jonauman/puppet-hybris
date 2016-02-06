class roles::yaml {
  File['/etc/facter'] -> File['/etc/facter/facts.d'] -> File['/etc/facter/facts.d/local.yaml']

  file { '/etc/facter': 
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 0755,
  }

  file { '/etc/facter/facts.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 0755,
  }
  
  file { '/etc/facter/facts.d/local.yaml':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template('roles/local.yaml'), 
 }
}
