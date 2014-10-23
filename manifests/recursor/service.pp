# = Class: pdns::recursor::service
#
# Create service pdns-recursor and enable it on boot
#
class pdns::recursor::service () {

  require 'pdns::recursor::config'

  service { 'pdns-recursor':
#    ensure => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

}
