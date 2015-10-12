require 'spec_helper'

describe package 'curl' do
  it { is_expected.to be_installed }
end

describe package 'git' do
  it { is_expected.to be_installed }
end

