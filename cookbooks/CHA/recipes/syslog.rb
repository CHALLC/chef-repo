#
# Cookbook Name:: CHA
# Recipe:: syslog
# Author:: Andrew Brader (<abrader@challc.net>)
#
# Copyright 2013, CHA, LLC
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

if node[:platform] == "centos"  && node[:platform_version].to_i < 6
  package "sysklogd" do
    action :install
  end
elsif node[:platform] == "centos"
  package "rsyslog" do
    action :install
  end
end


if node[:ipaddress] =~ /192.168/ && node[:platform] == "centos"  && node[:platform_version].to_i < 6
  template "/etc/syslog.conf" do
    source "hq_centos_5_syslog_conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, resources(:service => "syslog")
  end
elsif node[:ipaddress] =~ /192.168/ && node[:platform] == "centos" && node[:platform_version].to_i >= 6
  template "/etc/rsyslog.conf" do
    source "hq_centos_6_rsyslog_conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, resources(:service => "rsyslog")
  end
elsif node[:ipaddress] =~ /10.10/ && node[:platform] == "centos"  && node[:platform_version].to_i < 6
  template "/etc/syslog.conf" do
    source "de_centos_5_syslog_conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, resources(:service => "syslog")
  end
elsif node[:ipaddress] =~ /10.10/ && node[:platform] == "centos"  && node[:platform_version].to_i >= 6
  template "/etc/rsyslog.conf" do
    source "de_centos_6_rsyslog_conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, resources(:service => "rsyslog")
  end
end