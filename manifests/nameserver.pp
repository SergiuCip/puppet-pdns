# = Class: pdns::nameserver
#
# Installs and configures a PowerDNS nameserver
#
# Currently supported backends: mysql / postgresql
#
class pdns::nameserver(
  $conf_hash    = {},
  $group        = 'root',
  $includedir   = '/etc/pdns.puppet.d',
  $localaddress = '127.0.0.1',
  $localport    = '53',
  $owner        = 'root',
  $backend      = 'mysql',
  $db_host      = 'localhost',
  $db_user      = 'pdns',
  $db_password  = 'changeme',
  $db_name      = 'powerdns',
) {

  include pdns::nameserver::package
  include pdns::nameserver::config
  include pdns::nameserver::backend
  include pdns::nameserver::service

}
