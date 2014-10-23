# = Class: pdns::recursor::config
#
# Basic configuration of pdns::recursor
#
class pdns::recursor::config (
  $conf_hash    = $::pdns::recursor::conf_hash,
  $group        = $::pdns::recursor::group,
  $includedir   = $::pdns::recursor::includedir,
  $localaddress = $::pdns::recursor::localaddress,
  $localport    = $::pdns::recursor::localport,
  $owner        = $::pdns::recursor::owner,
) inherits pdns::recursor {

  require 'pdns::recursor::package'

  File {
    owner => $owner,
    group => $group,
  }

  file { $includedir:
    ensure => directory,
    mode   => '0755',
  }

  file { '/etc/pdns-recursor/recursor.conf':
    ensure  => present,
    mode    => '0644',
    content => template("${module_name}/recursor.conf.erb"),
    notify  => Service['pdns-recursor'],
    require => File[$includedir],
  }

  create_resources('pdns::recursor::file', $conf_hash)

}
