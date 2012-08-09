
# Cookbook Name:: CHA
# Recipe:: ad_auth
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

auth_packages = ["samba", "samba-winbind", "oddjob-mkhomedir", "openssh-server"]

auth_packages.each do |auth_pack|
  package auth_pack do
    action :install
  end
end

service "smb" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "winbind" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "oddjobd" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "sshd" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end


template "/etc/samba/smb.conf" do
  source "smb.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[smb]", :immediately
  notifies :restart, "service[winbind]", :immediately
  notifies :restart, "service[sshd]", :immediately
end

template "/etc/krb5.conf" do
  source "krb5.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[smb]", :immediately
  notifies :restart, "service[winbind]", :immediately
  notifies :restart, "service[sshd]", :immediately
end

template "/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf" do
  source "oddjobd-mkhomedir.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[oddjobd]", :immediately
end

if node[:platform] == "centos"  && node[:platform_version] == "6.2"
  template "/etc/pam.d/password-auth" do
    source "password-auth.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, "service[smb]", :immediately
    notifies :restart, "service[winbind]", :immediately
    notifies :restart, "service[sshd]", :immediately
  end
  
  template "/etc/pam.d/sshd" do
    source "pam-sshd.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, "service[smb]", :immediately
    notifies :restart, "service[winbind]", :immediately
    notifies :restart, "service[sshd]", :immediately
  end
  
  template "/etc/nsswitch.conf" do
    source "nsswitch.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, "service[smb]", :immediately
    notifies :restart, "service[winbind]", :immediately
    notifies :restart, "service[sshd]", :immediately
  end
end
  
  
  
  
  
  
  