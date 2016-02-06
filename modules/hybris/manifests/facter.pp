class hybris::facter {
  File {
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0755,
  }

  file { '/etc/facter/facts.d/hybris_commit.sh':
    source  => 'puppet:///modules/hybris/hybris_commit.sh'
  }

  file { '/etc/facter/facts.d/hybris_tag.sh':
    source  => 'puppet:///modules/hybris/hybris_tag.sh'
  }
}
