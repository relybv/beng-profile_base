# == Class: profile_base
#
# Full description of class profile_base here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class profile_base
(
  $ntpservers       = $::profile_base::params::ntpservers,
  $tcp_public_ports = $::profile_base::params::tcp_public_ports,
  $tcp_ports_global = $::profile_base::params::tcp_ports_global,
  $tcp_extra_rule1  = $::profile_base::params::tcp_extra_rule1,
  $tcp_rangea_src1  = $::profile_base::params::tcp_rangea_src1,
  $tcp_rangea_src2  = $::profile_base::params::tcp_rangea_src2,
  $tcp_rangea_src3  = $::profile_base::params::tcp_rangea_src3,
  $tcp_rangeb       = $::profile_base::params::tcp_rangeb,
  $tcp_rangec       = $::profile_base::params::tcp_rangec,
) inherits ::profile_base::params {


  class { '::profile_base::install': } ->
  class { '::profile_base::config': } ~>
  class { '::profile_base::service': } ->
  Class['::profile_base']
}
