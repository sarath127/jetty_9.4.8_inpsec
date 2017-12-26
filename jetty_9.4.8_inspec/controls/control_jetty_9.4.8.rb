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


control 'jetty-02' do
  impact 1.0
  title 'it should be lnstalled'
  desc  'it should be installed'
  describe command('java') do
      it { should exist }
  end
  describe processes('java.exe') do
      it { should exist }
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

=begin
control 'jetty-04' do
  impact 1.0
end
=end
