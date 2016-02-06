class activemq::proxy {
	case $operatingsystem {
		Ubuntu,Debian:  {
			package { "apache2": ensure => present}
			$service_name = 'apache2'
		}
		Centos,Amazon:  {
			package { "httpd": ensure => present }
			$service_name = "httpd"
		}
	}

	service { "apache":
		name	=> $service_name,
	        ensure 	=> "running",
	        enable 	=> "true",
	        require => $operatingsystem ? {
			Ubuntu => Package["apache2"],
			Debian => Package["apache2"],
			Centos => Package["httpd"],
			Amazon => Package["httpd"],
		},
	}

	file {'/etc/httpd/conf.d/activemq-httpd.conf':
		ensure  => "present",
		owner   => "root",
		group   => "root",
		mode    => 0644,
		source  => "puppet:///modules/activemq/activemq-httpd.conf",
		require => $operatingsystem ? {
			        Ubuntu => Package["apache2"],
				Debian => Package["apache2"],
				Centos => Package["httpd"],
				Amazon => Package["httpd"],
		},
		notify  => Service["apache"],
	}
	file {'/etc/httpd/htpasswd':
		ensure  => "present",
		owner   => "root",
		group   => "root",
		mode    => 0644,
		source  => "puppet:///modules/activemq/htpasswd",
		require => $operatingsystem ? {
			        Ubuntu => Package["apache2"],
				Debian => Package["apache2"],
				Centos => Package["httpd"],
				Amazon => Package["httpd"],
		},
		notify => Service["apache"],
	}
}

