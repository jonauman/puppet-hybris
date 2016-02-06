class solr {
  include solr::install
  include solr::config
  include solr::service
  include solr::proxy
}
