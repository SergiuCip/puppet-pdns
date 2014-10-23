# = Class pdns::nameserver::package
#
# Installation of the pdns package + backend package
# For now done with exec, needs to be changed to package type for puppet 3.6
#
# == TODO
#  Installion type (package/exec) based on check of puppet version
#
class pdns::nameserver::package (
  $backend = $::pdns::nameserver::backend,
) {

  exec { 'pdnsnameserver_install':
    command => '/usr/bin/yum --enablerepo=epel -y install pdns',
    creates => '/usr/sbin/pdns_server',
  }

  # When puppet 3.6 is used - change exec to package
  # package { 'pdns':
  #   ensure          => installed,
  #   install_options => { "--enablerepo" => "epel" },
  # }

  case $backend {
    'mysql': {
      exec { 'pdns-backend-mysql_install':
        command => '/usr/bin/yum --enablerepo=epel -y install pdns-backend-mysql',
        creates => '/usr/lib64/pdns/libgmysqlbackend.so',
      }
    }
    'psql': {
      exec { 'pdns-backend-mysql_install':
        command => '/usr/bin/yum --enablerepo=epel -y install pdns-backend-postgresql',
        creates => '/usr/lib64/pdns/libgpgsqlbackend.so',
      }
    }
    default: {
      fail('Unknown backend type - Currently MySQL and PostgreSQL are supported')
    }
  }

}
