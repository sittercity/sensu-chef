cookbook_file "/etc/sensu/conf.d/graylog2_server.json" do
  source "graylog2_server.json"
  mode 0644
  owner "sensu"
  group "sensu"
end


