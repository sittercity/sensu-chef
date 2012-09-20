cookbook_file "/etc/sensu/handlers/hipchat.rb" do
  source "sensu-community-plugins/handlers/notification/hipchat.rb"
  mode 0755
  owner "root"
  group "root"
end


gem_package "hipchat" do
  action :install
end

hipchat = data_bag_item("sensu", "hipchat")

template "/etc/sensu/conf.d/hipchat.json" do
  source "hipchat.json.erb"
  mode 0440
  owner "sensu"
  group "sensu"
  variables({
        :apikey => hipchat["apikey"],
        :room => hipchat["room"],
        })
end

template "/etc/sensu/conf.d/handler_hipchat.json" do
  source "handler_hipchat.json.erb"
  mode 0440
  owner "sensu"
  group "sensu"
end
