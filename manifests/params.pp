# == Class profile_base::params
#
# This class is meant to be called from profile_base.
# It sets variables according to platform.
#
class profile_base::params {
  $ntpservers = [ '172.18.99.210', '172.18.99.211' ]
  $tcp_public_ports = false
  $tcp_ports_global = false
  $tcp_extra_rule1 = false
  $tcp_rangea_src1 = false
  $tcp_rangea_src2 = false
  $tcp_rangea_src3 = false
  $tcp_rangeb = false
  $tcp_rangec = false
}
