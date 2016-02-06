class snmp::hiera {
  $snmpv3_user = hiera('snmp_user')
  $snmp_server = hiera('snmp_server')
  create_resources('snmp::snmpv3_user', $snmpv3_user)
  create_resources('snmp::server', $snmp_server)
}

