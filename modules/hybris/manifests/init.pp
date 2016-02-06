class hybris {
  include hybris::config
#  include hybris::facter
  include hybris::newrelic
  include hybris::patches 

  package { 'ruby-sass': ensure => installed }

}
