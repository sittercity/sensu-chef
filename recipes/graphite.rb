cookbook_file "/etc/sensu/handlers/graphite-tcp.rb" do
  source "sensu-community-plugins/handlers/metrics/graphite-tcp.rb"
  mode 0755
  owner "root"
  group "root"
end

graphite = data_bag_item("sensu", "graphite")

template "/etc/sensu/conf.d/graphite.json" do
  source "graphite.json.erb"
  mode 0440
  owner "sensu"
  group "sensu"
  variables({
        :server => graphite["server"],
        :port => graphite["port"]
        })
end

template "/etc/sensu/conf.d/handler_graphite-tcp.json" do
  source "handler_graphite-tcp.json.erb"
  mode 0440
  owner "sensu"
  group "sensu"
end
