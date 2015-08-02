require 'spec_helper.rb'

describe 'monitor::process' do
  let(:title) { 'monitor::process' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) {{
      :operatingsystem => 'CentOS',
      :osfamily => 'RedHat'
  }}
  let(:params) { {
      'name' => 'sample',
      'tool' => 'nagios'
  }}
  it { should compile }
end
