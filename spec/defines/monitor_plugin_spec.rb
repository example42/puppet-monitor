require 'spec_helper.rb'

describe 'monitor::plugin' do
  let(:title) { 'monitor::plugin' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) {{
      :operatingsystem => 'CentOS',
      :osfamily => 'RedHat'
  }}
  let(:params) { {
      'name' => 'sample',
      'tool' => 'nagios',
      'plugin' => 'check_proc'
  }}
  it { should compile }
end
