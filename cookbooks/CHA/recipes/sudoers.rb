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

template "/etc/pam.d/system-auth" do
  source "pam-system-auth.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/etc/sudoers" do
  source "sudoers.erb"
  owner "root"
  group "root"
  mode "0440"
end
