require 'spec_helper'

describe file '/usr/local/rvm' do
  specify {
    is_expected.to exist
    is_expected.to be_directory
  }
end

describe group 'rvm' do
  it { is_expected.to exist }
end

describe command 'gpg --list-key | grep D39DC0E3' do
  it { expect(subject.exit_status).to eq 0 }
end

describe file '/etc/rvmrc' do
  specify {
    is_expected.to exist
    is_expected.to contain('rvm_install_on_use_flag=1')
    is_expected.to contain('rvm_project_rvmrc=1')
    is_expected.to contain('rvm_gemset_create_on_use_flag=1')
    is_expected.to contain('rvm_auto_reload_flag=2')
    is_expected.to contain('rvm_autoinstall_bundler_flag=1')
  }
end

