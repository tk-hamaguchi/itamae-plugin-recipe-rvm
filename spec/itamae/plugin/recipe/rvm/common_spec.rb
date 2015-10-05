require 'spec_helper'

describe command 'gpg --list-key | grep D39DC0E3' do
  it { expect(subject.exit_status).to eq 0 }
end

describe package 'curl' do
  it { is_expected.to be_installed }
end

describe package 'git' do
  it { is_expected.to be_installed }
end

