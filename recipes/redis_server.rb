#gem_package redis do
#   action :install
#end

cookbook_file "/etc/sensu/plugins/redis-graphite.rb" do
    source "sensu-community-plugins/plugins/redis/redis-graphite.rb"
    mode 0755
    owner "root"
    group "root"
end

cookbook_file "/etc/sensu/conf.d/redis_server.json" do
  source "redis_server.json"
  mode 0644
  owner "sensu"
  group "sensu"
end
