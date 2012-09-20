#
# Cookbook Name:: sensu
# Recipe:: server
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

remote_directory File.join(node.sensu.directory, "handlers") do
  files_mode 0755
  files_backup false
  purge true
end

include_recipe "sensu::hipchat"
include_recipe "sensu::pagerduty"
include_recipe "sensu::graphite"
include_recipe "sensu::check_graphite"
include_recipe "sensu::graylog2"

cookbook_file "/etc/sensu/conf.d/handler_default_checks.json" do
  source "handlers/handler_default_checks.json"
  mode 0644
  owner "sensu"
  group "sensu"
end

cookbook_file "/etc/sensu/conf.d/check_cron.json.disabled" do
  source "sittercity-plugins/check_cron.json.disabled"
  mode 0644
  owner "sensu"
  group "sensu"
end

cookbook_file "/etc/sensu/README.md" do
  source "README.md"
  mode 0644
  owner "sensu"
  group "sensu"
end

cookbook_file "/etc/sensu/conf.d/http_checks.json" do
  source "http_checks.json"
  mode 0644
  owner "sensu"
  group "sensu"
end

service "sensu-server" do
  provider node.platform =~ /ubuntu|debian/ ? Chef::Provider::Service::Init::Debian : Chef::Provider::Service::Init::Redhat
  supports :status => true, :restart => true
  action [:enable, :start]
  subscribes :restart, resources(:sensu_config => node.name), :delayed
end
