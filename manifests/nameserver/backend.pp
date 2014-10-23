# = Class: pdns::nameserver::backend
#
# Basic backend configuration of pdns::nameserver
#
class pdns::nameserver::backend (
  $owner       = $::pdns::nameserver::owner,
  $group       = $::pdns::nameserver::group,
  $includedir  = $::pdns::nameserver::includedir,
  $backend     = $::pdns::nameserver::backend,
  $db_host     = $::pdns::nameserver::db_host,
  $db_user     = $::pdns::nameserver::db_user,
  $db_password = $::pdns::nameserver::db_password,
  $db_name     = $::pdns::nameserver::db_name,
) inherits pdns::nameserver {

  File {
    owner => $owner,
    group => $group,
  }

  case $backend {
    'mysql': {
      file { "${includedir}/pdns_mysql.conf":
        ensure  => present,
        mode    => '0600',
        content => template("${module_name}/pdns_mysql.conf.erb"),
        notify  => Service['pdns'],
        require => File[$includedir],
      }
    }
    'psql': {
      file { "${includedir}/pdns_psql.conf":
        ensure  => present,
        mode    => '0600',
        content => template("${module_name}/pdns_psql.conf.erb"),
        notify  => Service['pdns'],
        require => File[$includedir],
      }
    }
    default: {
      fail('Unknown backend type - Currently only mysql is supported')
    }
  }
}
