# = Class: pdns::recursor
#
# Installs and configures a PowerDNS recursor
#
# == Parameters
#
# [*conf_hash*]
#   Hash of additional configuration parameters for pdns-recursor
#   More information can be found in pdns::recursor::config
#
# [*owner*]
#   Owner of files/directory maintained by this module
#
# [*includedir*]
#   Include *.conf files from this directory
#
# [*group*]
#   Group of files/directory maintained by this module
#
# [*localaddress*]
#   IP addresses to listen on, separated by spaces or commas
#
# [*localport*]
#   Port to listen on
#
# === Examples
#
#   pdns::recursor::conf_hash:
#     max-mthreads:
#       value: 2048
#       ensure: absent
#     max-tcp-clients:
#       value: 128
#     minimum-ttl-override:
#       value: 0
#
class pdns::recursor(
  $conf_hash    = {},
  $group        = 'root',
  $includedir   = '/etc/pdns-recursor.puppet.d',
  $localaddress = $::ipaddress,
  $localport    = '53',
  $owner        = 'root',
) {

  include pdns::recursor::package
  include pdns::recursor::config
  include pdns::recursor::service

}
