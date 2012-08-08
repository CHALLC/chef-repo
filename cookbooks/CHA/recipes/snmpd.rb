#
# Cookbook Name:: CHA
# Recipe:: snmpd
# Author:: Andrew Brader (<abrader@challc.net>)
#
# Copyright 2012, CHA, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package "net-snmp" do
  action :install
end

service node[:snmpd][:service] do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

if node[:ipaddress] =~ /192.168/
  template "/etc/snmp/snmpd.conf" do
    source "hq_kvm_snmpd.conf.erb"
    owner "root"
    group root_group
    mode "0644"
    notifies :restart, resources(:service => node[:snmpd][:service])
  end
elsif node[:ipaddress] =~ /10.10.10/
   template "/etc/snmp/snmpd.conf" do
     source "de_kvm_snmpd.conf.erb"
     owner "root"
     group root_group
     mode "0644"
     notifies :restart, resources(:service => node[:snmpd][:service])
   end
 end