# == Definition: pdns::nameserver::inputs
#
# Defines config file(s) in the includedir based on a hash
#
# === Parameters
#
# [*key_name*]
#   We use the config option as title in the hash
#
# [*value*]
#   Value of the config option
#
# [*ensure*]
#   Option to create or delete config file
#
define pdns::nameserver::file (
  $value,
  $ensure     = present,
  $includedir = $::pdns::nameserver::includedir,
  $owner      = $::pdns::recursor::owner,
  $group      = $::pdns::recursor::group,
) {

  if $title == '' {
    fail('Can not create inputs with empty title/name')
  } else {
  $key_name = $title
  }

  file { "${includedir}/${name}.conf":
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => '0700',
    content => template("${module_name}/file.conf.erb"),
    notify  => Service['pdns'],
    require => File[$includedir],
  }

}
