require 'spec_helper.rb'

describe 'monitor::mount' do
  let(:title) { 'monitor::mount' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) {{
      :operatingsystem => 'CentOS',
      :osfamily => 'RedHat'
  }}
  let(:params) { {
      'name' => 'sample',
      'fstype' => 'ext2',
      'device' => 'sda1'
  }}
  it { should compile }
end
