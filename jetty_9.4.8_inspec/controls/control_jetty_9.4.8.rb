# encoding: utf-8
#
# Copyright 2017, sarath kumar
#
# dual licensed under the Apache License 2.0 and Eclipse Public License 1.0;
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#     http://www.eclipse.org/licenses/
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# author: Sarath kumar

title 'Jetty server config'

control 'jetty-01' do
  impact 1.0
  title 'checking java installed or not'
  desc  'checking java installed or not'
  describe command('java') do
      it { should exist }
  end
  describe processes('java.exe') do
      it { should exist }
  end
  describe service('jetty') do
      it { should be_installed }
      it { should be_enabled }
  end
end


control 'jetty-02' do
  impact 1.0
  title 'it should be listening'
  desc  'it should be listening'
  describe port(8080) do
      it { should be_listening }
  end
  describe host('localhost', port: 8080, protocol: 'tcp') do
      it { should be_reachable }
      it { should be_resolvable }
      its('ipaddress') { should include '127.0.0.1' }
  end
end


control 'jetty-03' do
  impact 1.0
  title 'checking operating system properties'
  desc  'checking operating system properties'
  describe os[:family] do
      it { should eq 'windows' }
  end
  describe os[:release] do
      it { should eq '10.0.15063' }
  end
  describe os[:arch] do
      it { should eq 'x86_64' }
  end
end


control 'jetty-04' do
  impact 1.0
  title 'checking user properties'
  desc  'checking user properties'
  describe user('sarath') do
      it { should exist }
      its('uid') { should eq "S-1-5-21-2966577821-4268542272-750097892-1001"}
      its('groups') { should eq ["ORA_DBA", "Administrators", "Performance Log Users"]}
  end
end


control 'jetty-05' do
  impact 1.0
  title 'checking jetty configuration'
  desc  'checking jetty configuration'
  describe file('C:\Program Files\Java\jetty\etc\jetty.xml') do
    it { should exist }
    it { should be_file }
  end
  describe file('C:\Program Files\Java\jetty\start.ini') do
    it { should exist }
  end
end

control 'jetty-06'do
  impact 1.0
  title 'checking user permissions'
  desc  'checking user permissions'
  describe directory('C:/Program Files/Java/jetty') do
    # verifies specific users
    it { should be_owned_by 'FLASH\sarath' }
    it { should be_readable.by_user('FLASH\sarath') }
    it { should be_writable.by_user('FLASH\sarath') }

    # only applicable to unix group system
    # it { should be_readable.by('owner') }
    # it { should be_readable.by('group') }
    # it { should be_readable.by('others') }
  end
end
