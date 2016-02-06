class activemq {
  include activemq::install
  include activemq::config
  include activemq::service
  include activemq::proxy
}
