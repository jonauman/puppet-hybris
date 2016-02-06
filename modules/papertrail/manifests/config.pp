class papertrail::config(
  $logfile = '/opt/hybris/log/tomcat/*.log',
  $logserver = 'logs.papertrailapp.com',
  $logserverport = '45054',
  )
   {

  if $rubyversion =~ /^1.8/ {
    $conf = "conf.yml-1.8.erb"
  } else {
    $conf = "conf.yml-1.9.erb"
  }
  
  file { '/etc/papertrail':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 0755,
  }

  file { '/etc/papertrail/conf.yml':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template("papertrail/$conf"),
  }
}
