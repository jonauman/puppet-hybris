class solr::install {
  
  file { '/etc/init.d/solr':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0755,
    source  => 'puppet:///modules/solr/init.d-solr',
  }
}
