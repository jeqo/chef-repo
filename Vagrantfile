# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(2) do |config|
  config.vm.define "box" do |box|
    box.vm.box = "oel65-64"
    box.vm.hostname = "jeqo-chef.localdomain"
    box.vm.network "private_network", ip: "192.168.56.100", auto_config: true
    box.vm.synced_folder "data" , "/data", :mount_options => ["dmode=777", "fmode=777"]

    box.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 2048]
      vb.customize ["modifyvm", :id, "--name"  , "jeqo-chef"]
      vb.customize ["modifyvm", :id, "--cpus"  , 2]
      vb.customize ["modifyvm", :id, "--chipset", "ich9"]
    end

    box.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.roles_path = "roles"

      #chef.add_role "elk-elasticsearch-server"
    end
  end

end
