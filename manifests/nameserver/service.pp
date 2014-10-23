# = Class: pdns::nameserver::service
#
# Create service pdns and enable it on boot
#
class pdns::nameserver::service () {

  require 'pdns::nameserver::config'

  service { 'pdns':
#    ensure => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

}
