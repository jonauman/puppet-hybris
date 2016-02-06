class solr::config ( $hash ) {

  $SOLR_HOME = '/opt/hybris/bin/ext-commerce/solrfacetsearch/resources/solr/server' 
  
  file  { 'solrconfig.xml':
    ensure  => present,
    owner   => hybris,
    group   => hybris,
    mode    => 0644,
    path    => "${SOLR_HOME}/conf/solrconfig.xml",
    content => template('solr/solrconfig.xml.erb'),
  }

  file { '/opt/hybris/bin/ext-commerce/solrfacetsearch/resources/solr/server/conf/ydata/y_synonyms_en.txt':
    ensure  => present,
    owner   => hybris,
    group   => hybris,
    mode    => 0644,
    source  => "puppet:///modules/solr/${env}/y_synonyms_en.txt",
  }

}
