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
  $ntpservers = $::profile_base::params::ntpservers,
) inherits ::profile_base::params {


  class { '::profile_base::install': } ->
  class { '::profile_base::config': } ~>
  class { '::profile_base::service': } ->
  Class['::profile_base']
}
