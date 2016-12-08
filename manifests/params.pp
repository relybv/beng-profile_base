# == Class profile_base::params
#
# This class is meant to be called from profile_base.
# It sets variables according to platform.
#
class profile_base::params {
  $ntpservers = [ '172.18.99.210', '172.18.99.211' ]
  $tcp_public_ports = false
  $tcp_ports_global = [ '20','21','22','80','443','445','1556','5666','8000','9100','9200','13720','13724' ]
  $tcp_extra_rule1 = false
  $tcp_rangea_src1 = false
  $tcp_rangea_src2 = false
  $tcp_rangea_src3 = false
  $tcp_9300_source1 = false
  $tcp_9300_source2 = false
  $tcp_9300_source3 = false
  $tcp_rangeb = '8080-8095'
  $tcp_rangec = '8011-8015'
  $internal_neta = '172.18.0.0/16'
  $internal_netb = '172.19.0.0/16'
  $internal_netc = '178.249.248.128/25'
  $udp_ports = [ '53','123','161']
  $tcp_rangea_ports = false
}
