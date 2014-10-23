# = Class: pdns::nameserver::config
#
# Basic configuration of pdns::nameserver
#
class pdns::nameserver::config (
  $conf_hash    = $::pdns::nameserver::conf_hash,
  $group        = $::pdns::nameserver::group,
  $includedir   = $::pdns::nameserver::includedir,
  $localaddress = $::pdns::nameserver::localaddress,
  $localport    = $::pdns::nameserver::localport,
  $owner        = $::pdns::nameserver::owner,
) inherits pdns::nameserver {

  require 'pdns::nameserver::package'

  File {
    owner => $owner,
    group => $group,
  }

  file { $includedir :
    ensure => directory,
    mode   => '0755',
  }

  file { '/etc/pdns/pdns.conf':
    ensure  => present,
    mode    => '0600',
    content => template("${module_name}/pdns.conf.erb"),
    notify  => Service['pdns'],
    require => File[$includedir],
  }

  create_resources('pdns::nameserver::file', $conf_hash)

}
