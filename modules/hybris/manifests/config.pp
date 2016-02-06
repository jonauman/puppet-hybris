class hybris::config( $hybris_home="/opt/hybris", $hash = [] ) {

  case $env {
    'prd': { $myenv = 'production' }
    'sta': { $myenv = 'staging' }
    default : { $myenv = $env }
  }

  File {
    ensure  => file,
    owner   => 'hybris',
    group   => 'hybris',
    mode    => 0644,
    }

  # license file
  file { "$hybris_home/config/licence/hybrislicence.jar":
    source  => 'puppet:///modules/hybris/hybrislicence.jar'
  }  
  
  # mysql jdbc driver
  file {'/opt/hybris/bin/platform/lib/dbdriver/mysql-connector-java-5.1.18.jar':
    source => 'puppet:///modules/hybris/mysql-connector-java-5.1.18.jar',
  } 

  # Only push out local.properties if manage = "yes"
  $managed = $hash["$env"]["$context"]['managed']
  notify{"Local properties managed:  $managed": }

  if $managed == "local.properties" {

    # local.properties
    file { "$hybris_home/config/local.properties":
      content => template('hybris/local.properties.erb'),
    }

    # warehouseintegration with activemq
    file {"${hybris_home}/bin/custom/warehouseintegration/resources/warehouseintegration-spring-${myenv}.xml":
      content  => template('hybris/warehouseintegration-spring.xml.erb')
    }
  }

}
