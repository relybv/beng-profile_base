# == Class profile_base::install
#
# This class is called from profile_base for install.
#
class profile_base::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # Enable network time protocol
  class { '::ntp':
    servers => $profile_base::ntpservers,
  }

  # Install puppet client
  ensure_resource('group', 'puppet', {'ensure' => 'present'})

  class { '::puppet::profile::agent':
    manage_repos => false,
    require      => Group['puppet'],
  }

  # Enable firewall
  class { 'beng_fw' :
    tcp_public_ports       => $profile_base::tcp_public_ports,
    tcp_ports_global       => $profile_base::tcp_ports_global,
    tcp_rangea_src1        => $profile_base::tcp_rangea_src1,
    tcp_rangea_src2        => $profile_base::tcp_rangea_src2,
    tcp_rangea_src3        => $profile_base::tcp_rangea_src3,
    tcp_rangeb             => $profile_base::tcp_rangeb,
    tcp_rangec             => $profile_base::tcp_rangec,
    internal_neta          => $profile_base::internal_neta,
    internal_netb          => $profile_base::internal_netb,
    internal_netc          => $profile_base::internal_netc,
    internal_netd          => $profile_base::internal_netd,
    internal_nete          => $profile_base::internal_nete,
    tcp_ports              => $profile_base::tcp_ports_global,
    udp_ports              => $profile_base::udp_ports,
    tcp_extra_rule1        => $profile_base::tcp_extra_rule1,
    tcp_extra_rule1_dport  => $profile_base::tcp_extra_rule1_dport,
    tcp_extra_rule1_source => $profile_base::tcp_extra_rule1_source,
    tcp_extra_rule2        => $profile_base::tcp_extra_rule2,
    tcp_extra_rule2_dport  => $profile_base::tcp_extra_rule2_dport,
    tcp_extra_rule2_source => $profile_base::tcp_extra_rule2_source,
  }

  # Create group and enable sudo
  group { 'wheel':
    ensure => present,
  }
  augeas { 'sudowheel':
    context => '/files/etc/sudoers',
    changes => [
      "set spec[user = '%wheel']/user %wheel",
      "set spec[user = '%wheel']/host_group/host ALL",
      "set spec[user = '%wheel']/host_group/command ALL",
      "set spec[user = '%wheel']/host_group/command/runas_user ALL",
      "set spec[user = '%wheel']/host_group/command/tag NOPASSWD",
      ],
  }

  # add vsftpd
  class { '::vsftpd':
    anonymous_enable   => 'NO',
    write_enable       => 'YES',
    ftpd_banner        => 'BenG FTP Server',
    chroot_local_user  => 'YES',
    chroot_list_enable => 'YES',
  }
  file { '/etc/vsftpd/chroot_list':
    content => 'root',
    require => Class['vsftpd'],
  }

  # Add host to BenG Nagios monitoring
  class { 'beng_nrpe': }

  # Add vmware toola
  class { 'beng_vmware': }
}
