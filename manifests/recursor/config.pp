# = Class: pdns::recursor::config
#
# Basic configuration of pdns::recursor
#
class pdns::recursor::config (
  $conf_hash         = $::pdns::recursor::conf_hash,
  $group             = $::pdns::recursor::group,
  $includedir        = $::pdns::recursor::includedir,
  $forward_zones     = $::pdns::recursor::forward_zones,
  $forward_zones_dir = $::pdns::recursor::forward_zones_dir,
  $localaddress      = $::pdns::recursor::localaddress,
  $localport         = $::pdns::recursor::localport,
  $owner             = $::pdns::recursor::owner,
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

  file { $forward_zones_dir:
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

  file { "${forward_zones_dir}/forward_zones":
    ensure  => present,
    mode    => '0644',
    content => template("${module_name}/forward_zones.erb"),
    notify  => Service['pdns-recursor'],
    require => File[$forward_zones_dir],
  }

  create_resources('pdns::recursor::file', $conf_hash)

}
