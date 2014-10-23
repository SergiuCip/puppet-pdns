# = Class: pdns
#
# This class installs pdns and sets up a basic configuration
#
# == Parameters:
#
#
class pdns () {

  include pdns::nameserver
  include pdns::recursor

}
