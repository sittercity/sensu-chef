cookbook_file "/etc/sensu/conf.d/carbon_cache.json" do
  source "carbon_cache.json"
  mode 0644
  owner "sensu"
  group "sensu"
end


