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

describe file '/etc/rvmrc' do
  specify {
    is_expected.to exist
    is_expected.to contain('rvm_install_on_use_flag=1').from(/^### Itamae cooked$/).to(/^### Itamae cooked$/)
    is_expected.to contain('rvm_project_rvmrc=1').from(/^### Itamae cooked$/).to(/^### Itamae cooked$/)
    is_expected.to contain('rvm_gemset_create_on_use_flag=1').from(/^### Itamae cooked$/).to(/^### Itamae cooked$/)
  }
end

