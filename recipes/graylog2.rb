cookbook_file "/etc/sensu/handlers/gelf.rb" do
  source "sensu-community-plugins/handlers/notification/gelf.rb"
  mode 0755
  owner "root"
  group "root"
end


gem_package "gelf" do
  action :install
end

gelf = data_bag_item("sensu", "gelf")

template "/etc/sensu/conf.d/gelf.json" do
  source "gelf.json.erb"
  mode 0440
  owner "sensu"
  group "sensu"
  variables({
        :server => gelf["server"],
        :port => gelf["port"],
        })
end

template "/etc/sensu/conf.d/handler_gelf.json" do
  source "handler_gelf.json.erb"
  mode 0440
  owner "sensu"
  group "sensu"
end
