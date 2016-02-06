class solr::proxy {
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
        exec { "mod_proxy" :
		command => "/usr/sbin/a2enmod proxy",
		unless  => "/bin/readlink -e /etc/apache2/mods-enabled/proxy.load",
		notify  => Service["apache2"],
		require => Package["apache2"],
	}
	exec { "mod_proxy_http" :
		command => "/usr/sbin/a2enmod proxy_http",
		unless  => "/bin/readlink -e /etc/apache2/mods-enabled/proxy_http.load",
		notify  => Service["apache2"],
		require => Package["apache2"],
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

	file {'/etc/apache2/conf.d/solr-proxy.conf':
		ensure  => "present",
		owner   => "root",
		group   => "root",
		mode    => 0644,
		source  => "puppet:///modules/solr/solr-proxy.conf",
		require => $operatingsystem ? {
			        Ubuntu => Package["apache2"],
				Debian => Package["apache2"],
				Centos => Package["httpd"],
				Amazon => Package["httpd"],
		},
		notify  => Service["apache"],
	}
	file {'/etc/apache2/htpasswd':
		ensure  => "present",
		owner   => "root",
		group   => "root",
		mode    => 0644,
		source  => "puppet:///modules/solr/htpasswd",
		require => $operatingsystem ? {
			        Ubuntu => Package["apache2"],
				Debian => Package["apache2"],
				Centos => Package["httpd"],
				Amazon => Package["httpd"],
		},
		notify => Service["apache"],
	}
}

