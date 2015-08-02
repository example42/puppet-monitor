require 'spec_helper.rb'

describe 'monitor::url' do
  let(:title) { 'monitor::url' }
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
