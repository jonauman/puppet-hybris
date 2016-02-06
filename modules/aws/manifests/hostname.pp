class aws::hostname(
  $route53_access_key,
  $route53_secret_key  
  ){

  # Resource ordering
  File['/root/.boto'] -> File['/etc/init.d/autoname'] ~> Service['autoname']


  case $::osfamily {
	'Debian': {
	  package { "cli53":
	    ensure    => installed,
	    provider  => pip,
	    require   => Package['python-pip'],
	  }
	 }
	'Amazon': {
	  exec { 'pip-install-cli53':
	  	path		=>  '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
	  	command		=> 'pip install cli53',
		cwd		=> '/',
		onlyif		=> 'test ! -f /usr/bin/cli53',
		require		=> Package['python-pip'],
	  }
	}
  } 
  # setup autoname
  file { "/usr/local/bin/autoname.sh":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0755,
    source  => "puppet:///modules/aws/autoname.sh"
  }

  file { "/etc/init.d/autoname":
    ensure  => link,
    target  => "/usr/local/bin/autoname.sh",
  }

  service { "autoname":
    enable  => true,
  }

  # boto credentials
  file { '/root/.boto':
    ensure    => present, 
    owner     => root,
    group     => root,
    mode      => 0600,
    content  => template('aws/.boto.erb'),
  }
}
