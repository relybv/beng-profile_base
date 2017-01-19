if ENV['BEAKER'] == 'true'
  # running in BEAKER test environment
  require 'spec_helper_acceptance'
else
  # running in non BEAKER environment
  require 'serverspec'
  set :backend, :exec
end

describe 'profile_base class' do

  context 'default parameters' do
    if ENV['BEAKER'] == 'true'
      # Using puppet_apply as a helper
      it 'should work idempotently with no errors' do
        pp = <<-EOS
        class { 'profile_base': }
        EOS

        # Run it twice and test for idempotency
        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes  => true)
      end
    end


  
   # the base profile should have ntp installed, enabled and running
    describe package('ntp') do
      it { is_expected.to be_installed }
    end

    describe service('ntpd') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe package('puppet-agent') do
      it { is_expected.to be_installed }
    end

    describe service('puppet') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe package('vsftpd') do
      it { is_expected.to be_installed }
    end

    describe service('vsftpd') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe package('net-snmp') do
      it { is_expected.to be_installed }
    end

    describe service('snmpd') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end


  end
end
