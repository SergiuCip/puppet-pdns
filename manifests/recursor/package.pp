# = Class pdns::recursor::package
#
# Installation of the pdns-recursor package
# For now done with exec, needs to be changed to package type for puppet 3.6
#
# == TODO
#  Installion type (package/exec) based on check of puppet version
#
class pdns::recursor::package () {

  exec { 'pdnsrecursor_install':
    command => '/usr/bin/yum --enablerepo=epel -y install pdns-recursor',
    creates => '/usr/sbin/pdns_recursor',
  }

  # When puppet 3.6 is used - change exec to package
  # package { 'pdns-recursor':
  #   ensure          => installed,
  #   install_options => { "--enablerepo" => "epel" },
  # }

}

