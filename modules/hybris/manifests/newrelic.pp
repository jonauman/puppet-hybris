class hybris::newrelic {
  
  File {
    owner => hybris,
    group => hybris,
  }  

  file { '/opt/hybris/bin/platform/tomcat-6/newrelic':
    ensure  => directory,
  }

  file { '/opt/hybris/bin/platform/tomcat-6/newrelic/newrelic.yml':
    ensure  => file,
    replace => true,
#    source  => 'puppet:///modules/hybris/newrelic.yml',
    content => template("hybris/${env}/newrelic.yml.erb"),
    require => File['/opt/hybris/bin/platform/tomcat-6/newrelic'],
  }

  file { '/opt/hybris/bin/platform/tomcat-6/newrelic/newrelic.jar':
    ensure  => file,
    source  => 'puppet:///modules/hybris/newrelic.jar',
    require => File['/opt/hybris/bin/platform/tomcat-6/newrelic'],
  }
}
