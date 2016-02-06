class solr::service {

  service { 'solr':
    enable  => true,
    require => [ File['/etc/init.d/solr'],
                  File['solrconfig.xml'] 
                ]
  }

}
