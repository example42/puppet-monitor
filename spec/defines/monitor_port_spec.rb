require 'spec_helper.rb'

describe 'monitor::port' do
  let(:title) { 'monitor::port' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) {{
      :operatingsystem => 'CentOS',
      :osfamily => 'RedHat'
  }}
  let(:params) { {
      'name' => 'sample',
      'port' => '42',
      'protocol' => 'tcp',
      'target' => '127.0.0.1',
      'tool' => 'puppi'
  }}
  it { should compile }
end
