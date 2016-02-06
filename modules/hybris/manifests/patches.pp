class hybris::patches {
  File {
    owner => hybris,
    group => hybris,
  }

  file { '/opt/hybris/bin/platform/ext/catalog/bin/catalogserver.jar':
    ensure  => file,
    source  => 'puppet:///modules/hybris/catalogserver.jar',
  }

}
