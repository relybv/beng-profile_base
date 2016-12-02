# == Class profile_base::params
#
# This class is meant to be called from profile_base.
# It sets variables according to platform.
#
class profile_base::params {
    $ntpservers = [ '172.18.99.210', '172.18.99.211' ]
}
