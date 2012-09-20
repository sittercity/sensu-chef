
directory "/etc/sensu/plugins/etsy-plugins/nagios_tools" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

cookbook_file "/etc/sensu/plugins/etsy-plugins/nagios_tools/check_graphite_data.py" do
  source "etsy-plugins/nagios_tools/check_graphite_data"
  mode 0755
  owner "root"
  group "root"
end

