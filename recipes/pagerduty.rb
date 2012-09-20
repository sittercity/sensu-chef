cookbook_file "/etc/sensu/handlers/pagerduty.rb" do
  source "sensu-community-plugins/handlers/notification/pagerduty.rb"
  mode 0755
  owner "root"
  group "root"
end


gem_package "redphone" do
  action :install
end

pagerduty = data_bag_item("sensu", "pagerduty")

template "/etc/sensu/conf.d/pagerduty.json" do
  source "pagerduty.json.erb"
  mode 0440
  owner "sensu"
  group "sensu"
  variables({
        :api_key => pagerduty["api_key"],
        })
end

template "/etc/sensu/conf.d/handler_pagerduty.json" do
  source "handler_pagerduty.json.erb"
  mode 0440
  owner "sensu"
  group "sensu"
end
