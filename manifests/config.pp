# == Class profile_base::config
#
# This class is called from profile_base for service config.
#
class profile_base::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

}
