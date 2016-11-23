# == Class profile_base::install
#
# This class is called from profile_base for install.
#
class profile_base::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { $::profile_base::package_name:
    ensure => present,
  }
}
