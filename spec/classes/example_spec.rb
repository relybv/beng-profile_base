require 'spec_helper'

describe 'profile_base' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo"
          })
        end

        context "profile_base class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_base') }

          it { is_expected.to contain_class('profile_base::install') }
          it { is_expected.to contain_class('profile_base::config') }
          it { is_expected.to contain_class('profile_base::service') }

          it { is_expected.to contain_group('puppet') }
          it { is_expected.to contain_group('wheel') }
          it { is_expected.to contain_augeas('sudowheel') }
        end
      end
    end
  end
end
