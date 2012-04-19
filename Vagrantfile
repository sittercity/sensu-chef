Vagrant::Config.run do |config|
  # vagrant baseboxes maintained by @portertech (recommended)
  # `vagrant box add ubuntu-11.10-server-i386 http://h4x.s3.amazonaws.com/vagrant/ubuntu-11.10-server-i386.box`
  config.vm.box = "ubuntu-11.10-server-i386"

  config.vm.customize [
    "modifyvm", :id,
    "--name", "Sensu Stack",
    "--memory", "1024"
  ]

  config.vm.provision :shell, :inline => "gem install chef --no-rdoc --no-ri"

  config.vm.forward_port 8080, 8080
  config.vm.forward_port 9000, 9000

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.data_bags_path = "data_bags"
    chef.roles_path = "roles"
    chef.add_role("vagrant")
  end
end
