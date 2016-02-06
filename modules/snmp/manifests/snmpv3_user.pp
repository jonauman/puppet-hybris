class snmp::snmpv3_user (
  $username,
  $authpass,
  $authtype = 'SHA',
  $privpass,
  $privtype = 'AES'
) {
  include snmp::server
  include snmp::params
  exec { "create-snmpv3-user-${username}":
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    command => "service snmpd stop ; net-snmp-config --create-snmpv3-user -ro -a ${privpass} ${username} && touch ${snmp::params::var_net_snmp}/${username}",
    creates => "${snmp::params::var_net_snmp}/${username}",
    user    => 'root',
    require => [ Package['snmpd'], File['var-net-snmp'], ],
    before  => Service['snmpd'],
  }
}
