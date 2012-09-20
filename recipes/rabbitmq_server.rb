["rest-client", "carrot-top"].each do |gem|
	gem_package "#{gem}" do
	  action :install
	end
end


["rabbitmq-alive", "rabbitmq-overview-metrics", "rabbitmq-queue-metrics"].each do |check|
  cookbook_file "/etc/sensu/plugins/#{check}.rb" do
    source "sensu-community-plugins/plugins/rabbitmq/#{check}.rb"
    mode 0755
    owner "root"
    group "root"
  end
end

cookbook_file "/etc/sensu/conf.d/rabbitmq_server.json" do
  source "rabbitmq_server.json"
  mode 0644
  owner "sensu"
  group "sensu"
end


