# == Class profile_base::install
#
# This class is called from profile_base for install.
#
class profile_base::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  include ntp

  group { 'puppet':
    ensure => present,
  }
  class { '::puppet::profile::agent':
    manage_repos => false,
    require      => Group['puppet'],
  }

  # Enable firewall
  class { 'beng_fw' :
    tcp_public_ports => $::tcp_public_ports,
    tcp_ports_global => $::tcp_ports_global,
    tcp_extra_rule1  => $::tcp_extra_rule1,
    tcp_rangea_src1  => $::tcp_9300_source1,
    tcp_rangea_src2  => $::tcp_9300_source2,
    tcp_rangea_src3  => $::tcp_9300_source3,
    tcp_rangeb       => $::tcp_rangeb,
    tcp_rangec       => $::tcp_rangec,
  }
}
