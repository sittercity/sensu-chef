#
# Cookbook Name:: sensu
# Recipe:: client
#
# Copyright 2011, Sonian Inc.
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
#

include_recipe "sensu::default"

cookbook_file "/etc/sensu/plugins/check-http.rb" do
  source "sensu-community-plugins/plugins/http/check-http.rb"
  mode 0755
  owner "root"
  group "root"
end

["check-load", "cpu-metrics", "disk-metrics", "memory-metrics", "interface-metrics", "vmstat-metrics", "load-metrics", "disk-capacity-metrics"].each do |check|
  cookbook_file "/etc/sensu/plugins/#{check}.rb" do
    source "sensu-community-plugins/plugins/system/#{check}.rb"
    mode 0755
    owner "root"
    group "root"
  end
end

cookbook_file "/etc/sensu/conf.d/system_checks.json" do
  source "system_checks.json"
  mode 0644
  owner "sensu"
  group "sensu"
end

service "sensu-client" do
  provider node.platform =~ /ubuntu|debian/ ? Chef::Provider::Service::Init::Debian : Chef::Provider::Service::Init::Redhat
  supports :status => true, :restart => true
  action [:enable, :start]
  subscribes :restart, resources(:sensu_config => node.name), :delayed
end
