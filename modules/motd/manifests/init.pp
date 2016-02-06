class motd {

  package { 'figlet':
    ensure  =>  installed,
  } 
  file { '/etc/motd.data':
    ensure  => file,
    content => template("${module_name}/motd.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }
  exec { 'genmotd':
    path    =>  '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    command =>  '/usr/bin/figlet -w 120 -f small `facter hostname` > /etc/motd && cat /etc/motd.data >> /etc/motd',
    require =>  [Package['figlet'],File['/etc/motd.data']],
  }
}     
